
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

election_result <- function(id, data){
  
  # namespace
  ns <- NS(id)
  
  # return ui
  div(
    h2(data$election_title),
    actionButton(inputId = "result_close", icon = icon("close"), "fermer"),
    
    h3("Chiffres nationaux"),
    p(paste0("Participation : ", data$ratio_votants_inscrits, "%"), br(),
      paste0("Abstention : ", data$ratio_abstentions_inscrits, "%")),
    
    h3("Filtres"),
    textInput(inputId = ns("commune_search"),
              label = "Commune"),
    div(id = ns("commune-placeholder")),
    
    h3("Résultats"),
    div(id = ns("result-placeholder")),
    
    maplibreOutput(ns("map")),
    
    div(id = ns("candidates-placeholder"))
    
  )
    
}
