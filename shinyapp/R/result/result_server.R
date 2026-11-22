

result_server <- function(id, election, summary) {
  moduleServer(id, function(input, output, session) {
    
    # //////////////////////////////////////////////////////////////////////////
    # Before calling the module
    
    # prepare
    file_name <- "election_communes"
    file_ext <- ".parquet"
    url <- file.path(Sys.getenv("DATA_HOME"), paste0(file_name, file_ext))
    
    # columns to load
    colums <- c("id_election",
                "code_commune", 
                "libelle_commune")
    
    # read data
    communes <- arrow::open_dataset(url) |>
      select(all_of(colums)) |> 
      filter(id_election == election) |>
      collect()
    

    # read data
    file_name <- "b8703c69-a18f-46ab-9e7f-3a8368dcb891"
    file_ext <- ".parquet"
    url <- file.path(Sys.getenv("DATA_HOME"), paste0(file_name, file_ext))
    
    # columns to load
    colums <- c("id_election",
                "code_commune",
                "nuls",
                "blancs",
                "votants",
                "exprimes",
                "inscrits",
                "abstentions")
    
    # read data
    result <- arrow::open_dataset(url) |>
      select(all_of(colums)) |>
      filter(id_election == election)
    
    
    # -- result by candidate
    file_name <- "52a11762-45b4-414f-b6a2-eaa290217dc6"
    file_ext <- ".parquet"
    url <- file.path(Sys.getenv("DATA_HOME"), paste0(file_name, file_ext))
    
    result_candidate <- arrow::open_dataset(url) |>
      filter(id_election == election)
    
    
    # //////////////////////////////////////////////////////////////////////////
    # Election result
    
    # namespace
    ns <- NS(id)

    # init map
    output$map <- renderMaplibre({
      maplibre(center = c( 2.4294, 46.5389),
               zoom = 4.5,
               fitBoundsOptions = list(
                 padding = list(top = 40, bottom = 40, left = 40, right = 40))) |>
        add_fill_layer(id = "contour",
                       source = st_sf(geometry = st_sfc(crs = 4326)),
                       fill_color = "#ff8044",
                       fill_opacity = 0.25)
    })
    
    # Update participation after the flush cycle
    session$onFlushed(function() {
      
      shinyjs::delay(500, {
        update_meter(id = ns("participation"), value = summary$ratio_votants_inscrits)
        shinyjs::addClass(selector = paste0("#", ns("map-container")), class = "is-loaded")})
      
    }, once = TRUE)


      
    
    # //////////////////////////////////////////////////////////////////////////
    # commune search
    
    observeEvent(input$commune_search, {
      
      # cleanup choices
      removeUI(selector = paste0("#", ns("commune-placeholder"), " > a"),
               multiple = TRUE,
               immediate = TRUE)
      
      # search (start with)
      res <- communes |> 
          filter(grepl(paste0("^", input$commune_search), libelle_commune, ignore.case = TRUE))
      
      # update count
      shinyjs::html(selector = paste0("#", ns("search-count")), 
                    html = paste(nrow(res), "résultats", 
                                 if(nrow(res) > 10) tooltip(icon("triangle-exclamation"), 
                                                            "Réduire à 10 maximum en utilisant le champ de recherche.",
                                                            options = list(customClass = "vt-tip"))
                                 else icon("circle-check")))
      
      # secure against empty or too many results
      req(nrow(res) && nrow(res) <= 10)
      
      # update choices
      insertUI(selector = paste0("#", ns("commune-placeholder")),
               where = "beforeEnd",
               ui = apply(res, 
                          MARGIN = 1, 
                          FUN = \(x)
                          a(href = "#results", 
                            onclick = sprintf("Shiny.setInputValue('%s', '%s', {priority: 'event'});", 
                                              ns("select_commune"), 
                                              x[['code_commune']]),
                            x[['libelle_commune']])))
      
    })
    
    
    # //////////////////////////////////////////////////////////////////////////
    # commune select
    
    observeEvent(input$select_commune, {
  
      # ////////////////////////////////////////////////////////////////////////
      # cleanup ui 
      
      # candidate rows
      removeUI(selector = paste0("#", ns("cand-list"), "> div.cand-row"),
               multiple = TRUE,
               immediate = TRUE)
      
      
      # ////////////////////////////////////////////////////////////////////////
      # -- build datamart
      res_commune <- result |>
        filter(code_commune == input$select_commune) |>
        group_by(code_commune) |>
        
        # sum all numeric columns
        summarise(across(where(is.numeric), ~ sum(.x, na.rm = TRUE)), .groups = 'drop') |>
        
        # compute query
        collect()
      
      # update stats
      update_stats(values = res_commune)
      
      # update local participation
      local_part <- ratio(res_commune$votants, res_commune$inscrits)
      local_part_diff <- local_part - summary$ratio_votants_inscrits
      update_meter(id = ns("local-participation"), value = local_part)
      shinyjs::html(id = "local-participation-text", 
                    paste("La participation est", sprintf("%.2f", abs(local_part_diff)), ifelse(abs(local_part_diff) < 2, "point", "points"), 
                          ifelse(local_part_diff >= 0, "supérieure", "inférieure"), 
                          "à la moyenne nationale pour ce scrutin", paste0("(", summary$ratio_votants_inscrits, "%).")))
      
      # get contour
      contour_sf <- st_read(contour_commune(input$select_commune), quiet = TRUE)
      
      # update map
      maplibre_proxy("map") |> 
        set_source(layer_id = "contour", source = contour_sf) |>
        fit_bounds(contour_sf, 
                   animate = TRUE, 
                   padding = 40)
      
      
      # ////////////////////////////////////////////////////////////////////////
      # Candidates' performance
      
      # Select candidates' data
      res_commune_cand <- result_candidate |>
        filter(code_commune == input$select_commune) |>
        collect() |>
        group_by(no_panneau) |>
        summarise(voix = sum(voix, na.rm = TRUE),
                  nom = unique(nom),
                  prenom = unique(prenom),
                  libelle_abrege_liste = unique(libelle_abrege_liste)) |>
        arrange(desc(voix))
      
      # replace candidates' performance
      insertUI(selector = paste0("#", ns("cand-list")),
               where = "beforeEnd",
               ui = apply(res_commune_cand,
                          MARGIN = 1,
                          FUN = \(x)
                          cand_row(name = paste(x[['prenom']], x[['nom']]), 
                                   voix = x[['voix']], 
                                   ratio = ratio(as.numeric(x[['voix']]), res_commune$exprimes))))
      
      # trigger JS to observe candidate rows (animate when visible)
      session$onFlushed(function() {
        session$sendCustomMessage("observeCandRows", list())
      }, once = TRUE)
      
    }, ignoreInit = TRUE)
    
    
    # Return cleanup function for the caller to invoke
    list(destroy = session$destroy)
    
  })
}
