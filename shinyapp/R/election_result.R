
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

election_result <- function(data){
  
  # return ui
  div(
    h2(data$election_title),
    actionButton(inputId = "result_close", icon = icon("close"), "fermer"),
    
    p(paste0("Participation : ", data$ratio_votants_inscrits, "%"), br(),
      paste0("Abstention : ", data$ratio_abstentions_inscrits, "%"))
  )
    
}
