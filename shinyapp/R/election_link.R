
#' Election Link
#'
#' @param data a data.frame (a subset of summary)
#'
#' @returns a list of links
#' @export
#'
#' @examples

election_link <- function(data){
  
  lapply(1:nrow(data), 
         \(x) a(href = "#", 
                onclick = sprintf("Shiny.setInputValue('global_nav', {id: '%s'}, {priority: 'event'});", 
                                  data[x, ]$id_election), data[x, ]$election_title))
  
}
