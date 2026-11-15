
# ------------------------------------------------------------------------------
# This is the server logic of the Shiny web application.
# ------------------------------------------------------------------------------

# -- Define server logic
function(input, output, session) {
  
  # ////////////////////////////////////////////////////////////////////////////
  # Read election summary
  
  summary <- read.csv(file = file.path(Sys.getenv("DATA_HOME"), "election_summary.csv"))
  
  
  # ////////////////////////////////////////////////////////////////////////////
  # Update UI
  
  # nb of elections
  shinyjs::html(id = "election-summary-placeholder", 
                sprintf("%s résultats disponibles.", nrow(summary)))
}
