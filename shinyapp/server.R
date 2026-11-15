
# ------------------------------------------------------------------------------
# This is the server logic of the Shiny web application.
# ------------------------------------------------------------------------------

# -- Define server logic
function(input, output, session) {
  
  # ////////////////////////////////////////////////////////////////////////////
  # Read election summary
  
  summary <- read.csv(file = file.path(Sys.getenv("DATA_HOME"), "election_summary.csv"))
  
  
  # ////////////////////////////////////////////////////////////////////////////
  # Get dataset update
  
  # params
  base <- "https://www.data.gouv.fr"
  endpoint <- "api/1/datasets"
  id <- "6481e741d4cf002ec0efec9d"
  
  # build url
  url <- paste(base, endpoint, id, sep = "/")
  
  # call API
  res <- iker::call_api(url, header = list())
  if(res$status_code == 200)
    dataset_meta <- jsonlite::fromJSON(res$content)
  else
    warning("Error while retrieving data from data.gouv API", call. = F)
  
  
  # ////////////////////////////////////////////////////////////////////////////
  # Navigation
  
  # open tab
  observeEvent(input$global_nav, {
    
    ui <- election_result(data = summary |>
                             filter(id_election == "2017_pres_t1"))
    
    
    nav_insert(id = "navbar",
               nav = nav_panel(title = "Résultats",
                               value = "result",
                               ui),
               target = "home",
               position = "after",
               select = TRUE)
    
    
  })
  
  
  # close result
  observeEvent(input$result_close, {
    
    nav_remove(id = "navbar",
               target = "result")
    
  })
  
  
  # ////////////////////////////////////////////////////////////////////////////
  # Update UI
  
  # nb of elections
  shinyjs::html(id = "election-summary-placeholder", 
                sprintf("%s résultats disponibles.", nrow(summary)))
  
  # last update
  shinyjs::html(id = "dataset-meta",
                sprintf("Mise à jour : %s", dataset_meta$last_update))
  
  # election types
  ui <- lapply(unique(election_mapping$title), 
               \(x) a(href = "#", 
                      onclick = sprintf("Shiny.setInputValue('global_nav', '%s', {priority: 'event'});", 
                                        x), x))
  
  insertUI(selector = "#election-type-placeholder", 
           where = "beforeEnd", 
           ui)

  # election year  
  ui <- lapply(sort(unique(summary$election_year), decreasing = TRUE), 
               \(x) a(href = "#", 
                      onclick = sprintf("Shiny.setInputValue('global_nav', '%s', {priority: 'event'});", 
                                        x), x))
  
  insertUI(selector = "#election-year-placeholder", 
           where = "beforeEnd", 
           ui)
  
}
