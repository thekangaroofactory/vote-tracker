
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
                 meter(id = ns("participation"), title = "Participation")),
    
    
    # Search
    div(class = "search-container",
        
        # help
        div(class = "search-help", 
            popover(icon("circle-info"), 
                    placement = "right",
                    options = list(customClass = "vt-pop"),
                    title = "Recherche", 
                    p("La recherche s'effectue sur les communes dont le nom « commence par »."),
                    tags$ul(
                      tags$li("Les mots sont séparés par des tirets (ex: Wallis-Et-Futuna)"),
                      tags$li("« Saint » s'écrit en toute lettre (ex: Sainte-Rose)"),
                      tags$li("Les majuscules sont ignorées"),
                      tags$li("Les villes étrangères correspondent aux ambassades et consulats")),
                    p("Réduisez le nombre de résultats à 10 maximum pour qu'ils soient affichés."))),
        
        # search area
        h2("Rechercher"),
        div(class = "search-area",
          textInput(inputId = ns("commune_search"), label = "", placeholder = "nom de commune"),
          span(class = "search-count", id = ns("search-count"), "")),
        
        # result area
        div(id = ns("commune-placeholder"))),
    
    # Results
    h3(id = "results", class = "indented", "Résultats"),
    
    # Map    
    div(id = ns("map-container"),
        class = "map",
        maplibreOutput(ns("map"))),
    
    div(class = "stats-container stats-grid indented", stat_ui(id)),
    div(id = ns("candidates-placeholder"))
    
  )
    
}
