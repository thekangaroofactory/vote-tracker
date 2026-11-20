
#' Election Result
#'
#' @param data a data.frame
#' 
#' @details 
#' `data` is a single row slice of summary
#'
#' @returns an HTML tag
#' @export
#'
#' @examples
#' election_result(data)

election_result <- function(id, title = "", subtitle = ""){
  
  # namespace
  ns <- NS(id)
  
  # return ui
  div(
    
    # Election title
    hero_section(title = title,
                 subtitle = subtitle,
                 namespace = id,
                 close = TRUE,
                 
                 # Overall participation
                 meter(title = "Participation")),

    
    # Filters
    h3("Filtres"),
    textInput(inputId = ns("commune_search"),
              label = "Commune"),
    div(id = ns("commune-placeholder")),
    
    
    # Results
    h3("Résultats"),
    div(id = ns("result-placeholder")),
    
    maplibreOutput(ns("map")),
    
    div(id = ns("candidates-placeholder"))
    
  )
    
}
