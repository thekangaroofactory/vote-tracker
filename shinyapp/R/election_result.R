
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
  
  # prepare
  type <- election_mapping |> filter(type == data$election_type) |> pull("title")
  
  # return ui
  div(
    h2("Élection", type, data$election_year, paste0("(", toupper(data$election_tour), ")")),
    actionButton(inputId = "result_close", icon = icon("close"), "fermer"),
    
    p(paste0("Participation : ", data$ratio_votants_inscrits, "%"), br(),
      paste0("Abstention : ", data$ratio_abstentions_inscrits, "%"))
  )
    
}
