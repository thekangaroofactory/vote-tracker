
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
  
  observeEvent(input$global_nav, {
    
    str(input$global_nav)
    
  })
  
  
  # ////////////////////////////////////////////////////////////////////////////
  # Update UI
  
  # nb of elections
  shinyjs::html(id = "election-summary-placeholder", 
                sprintf("%s résultats disponibles.", nrow(summary)))
  
  # last update
  shinyjs::html(id = "dataset-meta",
                sprintf("Mise à jour : %s", dataset_meta$last_update))
}
