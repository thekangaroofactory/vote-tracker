

result_server <- function(id) {
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
    data <- arrow::read_parquet(url, col_select = all_of(colums))
    
    # filter
    communes <- data |> 
      filter(id_election == "2026_muni_t2")
    
    
    # //////////////////////////////////////////////////////////////////////////
    # Election result
    
    # namespace
    ns <- NS(id)
    
    # commune search
    observeEvent(input$commune_search, {
      
      str(input$commune_search)

      removeUI(selector = paste0("#", ns("commune-placeholder"), " > a"),
               multiple = TRUE,
               immediate = TRUE)
            
      req(nchar(input$commune_search) > 3)
      
      # search
      res <- communes |> 
        filter(grepl(input$commune_search, libelle_commune, ignore.case = TRUE))
      
      str(res)
      
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
    
    
    observeEvent(input$select_commune, {
      
      str(input$select_commune)
      
    })
    
    
    
    # Return cleanup function for the caller to invoke
    list(destroy = session$destroy)
    
  })
}
