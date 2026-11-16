

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
    communes <- arrow::read_parquet(url, col_select = all_of(colums)) |> 
      filter(id_election == "2026_muni_t2")
    

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
    result <- arrow::read_parquet(url, col_select = all_of(colums)) |> 
      filter(id_election == "2026_muni_t2")
    
    
    # //////////////////////////////////////////////////////////////////////////
    # Election result
    
    # namespace
    ns <- NS(id)
    
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
        filter(grepl(input$commune_search, libelle_commune, ignore.case = TRUE))
      
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
        summarise(across(where(is.numeric), ~ sum(.x, na.rm = TRUE)), .groups = 'drop')
      
      # cleanup UI
      removeUI(selector = paste0("#", ns("result-content")),
                                 immediate = TRUE)
      
      # update UI
      insertUI(selector = paste0("#", ns("result-placeholder")),
               where = "beforeEnd",
               ui = div(id = ns("result-content"), res_commune$votants))
      
    })
    
    
    # Return cleanup function for the caller to invoke
    list(destroy = session$destroy)
    
  })
}
