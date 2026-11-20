
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
                 meter(id = "participation", title = "Participation")),

    
    # Filters
    textInput(inputId = ns("commune_search"),
              label = "Rechercher une commune :"),
    div(id = ns("commune-placeholder")),
    
    
    # Results
    h3("Résultats"),
    div(id = ns("result-placeholder")),
    
    div(class = "map",
        maplibreOutput(ns("map"))),
    
    div(id = ns("candidates-placeholder"))
    
  )
    
}
