
# ------------------------------------------------------------------------------
# This is the server logic of the Shiny web application.
# ------------------------------------------------------------------------------

# -- Define server logic
function(input, output, session) {
  
  # ////////////////////////////////////////////////////////////////////////////
  # Read local files
  
  summary <- readr::read_csv(file = file.path(Sys.getenv("DATA_HOME"), "election_summary.csv"), show_col_types = F)
  next_election <- readr::read_csv(file = file.path(Sys.getenv("DATA_HOME"), "next_election.csv"), show_col_types = F)

    
  # ////////////////////////////////////////////////////////////////////////////
  # Get dataset update
  
  # params
  base <- "https://www.data.gouv.fr"
  endpoint <- "api/1/datasets"
  id <- "6481e741d4cf002ec0efec9d"
  
  # build url
  url <- paste(base, endpoint, id, sep = "/")
  
  # call API
  res <- iker::with_cache(iker::call_api(url, header = list()), encrypt = FALSE)
  if(res$status_code == 200)
    dataset_meta <- jsonlite::fromJSON(res$content)
  else
    warning("Error while retrieving data from data.gouv API", call. = F)
  
  
  # ////////////////////////////////////////////////////////////////////////////
  # Navigation
  
  # open tab
  observeEvent(input$global_nav, {

    # check name in list
    if(names(input$global_nav) == "type"){
      
      # prepare ui
      ui <- election_link(summary[summary$election_type_label %in% input$global_nav$type, ])
      
      # update ui
      shinyjs::html(id = "election-type-content",
                    html = as.character(tagList(ui)))
      
    } else if(names(input$global_nav) == "year"){
      
      # prepare ui
      ui <- election_link(summary[summary$election_year %in% input$global_nav$year, ])
      
      # update ui
      shinyjs::html(id = "election-year-content",
                    html = as.character(tagList(ui)))
      
    } else if(names(input$global_nav) == "id"){

      # election summary
      e_summary <- summary |> 
        filter(id_election == input$global_nav$id)
      
      # generate unique module id
      # note: starts with a char to avoid JS error!
      module_id <- paste0("k", as.character(trunc(as.numeric(Sys.time()) * 10)))
      
      # compute ui
      ui <- election_result(id = module_id, title = e_summary$election_title)
      
      # insert tab ui
      nav_insert(id = "navbar",
                 nav = nav_panel(title = "Résultats",
                                 value = module_id,
                                 class = "vt-tab p-5",
                                 ui),
                 target = "home",
                 position = "after",
                 select = TRUE)
      
      # call module server
      result_server(id = module_id, 
                    election = input$global_nav$id, 
                    summary = e_summary)
      
    }
    
  })
  
  
  # close result
  observeEvent(input$close_tab, {
    
    # drop ui
    nav_remove(id = "navbar",
               target = input$close_tab)
    
    # cleanup module
    session$destroy(input$close_tab)
    
  })
  
  
  # ////////////////////////////////////////////////////////////////////////////
  # Update UI
  
  # -- next election
  incoming <- next_election |>
    filter(date >= Sys.Date()) |>
    head(n = 1L)
  
  # insert UI
  if(nrow(incoming))
    insertUI(selector = "#next-election-placeholder",
             where = "beforeEnd",
             ui = next_election_ui(incoming))
  
  
  # nb of elections
  shinyjs::html(id = "election-summary-placeholder", 
                sprintf("%s résultats disponibles.", nrow(summary)))
  
  # last update
  shinyjs::html(id = "dataset-meta",
                sprintf("Mise à jour : %s", dataset_meta$last_update))
  
  # election types
  # cant / dpmt will send two events from the same click
  ui <- lapply(unique(summary$election_type_label), 
               \(x) a(href = "#", 
                      onclick = sprintf("Shiny.setInputValue('global_nav', {type: '%s'}, {priority: 'event'});", 
                                        x), x))
  
  insertUI(selector = "#election-type", 
           where = "beforeEnd", 
           ui)

  # election year  
  ui <- lapply(sort(unique(summary$election_year), decreasing = TRUE), 
               \(x) a(href = "#", 
                      onclick = sprintf("Shiny.setInputValue('global_nav', {year: %i}, {priority: 'event'});", 
                                        x), x))
  
  insertUI(selector = "#election-year", 
           where = "beforeEnd", 
           ui)
  
}
