

result_server <- function(id, election) {
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
    
    
    # //////////////////////////////////////////////////////////////////////////
    # Election result
    
    # namespace
    ns <- NS(id)
    
    # init map
    output$map <- renderMaplibre({
      maplibre(bounds = c(-5.0, 42.5, 9.56, 51.15),
               fitBoundsOptions = list(
                 padding = list(top = 40, bottom = 40, left = 40, right = 40))) |> 
        add_fill_layer(id = "contour",
                       source = st_sf(geometry = st_sfc(crs = 4326)),
                       fill_color = "#ff8044",
                       fill_opacity = 0.2)
    })

        
    # commune search
    observeEvent(input$commune_search, {

      # cleanup choices
      removeUI(selector = paste0("#", ns("commune-placeholder"), " > a"),
               multiple = TRUE,
               immediate = TRUE)
      
      # threshold
      req(nchar(input$commune_search) > 3)
      
      # search
      res <- communes |> 
        filter(grepl(paste0("^", input$commune_search), libelle_commune, ignore.case = TRUE))
      
      # secure from empty search result
      if(nrow(res))
        
        # update choices
        insertUI(selector = paste0("#", ns("commune-placeholder")),
                 where = "beforeEnd",
                 ui = apply(res, 
                            MARGIN = 1, 
                            FUN = \(x)
                            a(href = "#", 
                              onclick = sprintf("Shiny.setInputValue('%s', '%s', {priority: 'event'});", 
                                                ns("select_commune"), 
                                                x[['code_commune']]),
                              x[['libelle_commune']])))
      
    }, ignoreInit = TRUE)
    
    
    # commune select
    observeEvent(input$select_commune, {
      
      # build datamart
      res_commune <- result |>
        filter(code_commune == input$select_commune) |>
        group_by(code_commune) |>
        
        # sum all numeric columns
        summarise(across(where(is.numeric), ~ sum(.x, na.rm = TRUE)), .groups = 'drop') |>
        
        # compute query
        collect()
      
      # cleanup UI
      removeUI(selector = paste0("#", ns("result-content")),
                                 immediate = TRUE)
      
      # update UI
      insertUI(selector = paste0("#", ns("result-placeholder")),
               where = "beforeEnd",
               ui = div(id = ns("result-content"), 
                        "Inscrits :", res_commune$inscrits,
                        "Votants :", res_commune$votants,
                        "Abstentions :", res_commune$abstentions,
                        "Nuls", res_commune$nuls,
                        "Blancs", res_commune$blancs,
                        "Exprimés", res_commune$exprimes))
      
      # get contour
      contour_sf <- st_read(contour_commune(input$select_commune), quiet = TRUE)
      
      # update map
      maplibre_proxy("map") |> 
        set_source(layer_id = "contour", source = contour_sf) |>
        fit_bounds(contour_sf, 
                   animate = TRUE, 
                   padding = 40)
      
    })
    
    
    # Return cleanup function for the caller to invoke
    list(destroy = session$destroy)
    
  })
}
