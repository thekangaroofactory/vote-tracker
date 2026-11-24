

home_ui <- function(){
  
  tagList(
    
    # -- intro
    div(class = "mb-5",
        hero_section(title = paste0("vote", span(class = "text-secondary", "T", .noWS = "outside"), "racker"),
                 subtitle = "Visualiser les résultats des éléctions.")),
    
    # -- Section (Project)
    div(class = "mb-5",
        layout_columns(
          col_widths = c(7, 5),
          gap = "2rem",
          
          div(
            h2(class = "mb-4 fw-bold", "Présentation"),
            p("L'application présente les résultats des élections françaises à partir des données publiées 
              par le Ministère de l'Intérieur et des Outre-mer, agrégées par la plateforme", 
              a(href = "https://www.data.gouv.fr/", target = "_blank", "datagouv"), ".", br(),
              "Elle n'est affiliée à aucun organisme public ni parti politique."),
            p("Pour", strong("soutenir"), "son développement, consultez cette", 
              a(href = "#", 
                onclick = "Shiny.setInputValue('switch_tab', 'project', {priority: 'event'});",
                "page."))),
          
          # -- next election
          div(id = "next-election-placeholder"))),
    
    
    # -- Section (dataset)
    h2(class = "mb-4 fw-bold", "Données"),
    p("Les données utilisées par l'outil sont mises à jour lorsque", tags$em("datagouv"),
      "publie une nouvelle version.", br(),
      "Pour en savoir plus sur les sources de données et leur gestion, clickez",
      a(href = "#", 
        onclick = "Shiny.setInputValue('switch_tab', 'data', {priority: 'event'});",
        "ici.")),
    div(id = "dataset-meta", class = "box-fit text-sm"),
    
    tags$hr(class = "flag my-5"),
    
    
    # -- Section (elections)
    div(class = "mt-75 mb-60 text-em",
        div(id = "election-summary-placeholder")),
    
    # results (columns)
    div(class = "side-by-side",
        
        # left: by types
        div(
          h4(class = "mb-4 fw-bold", "Par type"),
          div(id = "election-type-placeholder",
              div(id = "election-type", class = "tag-list"),
              div(id = "election-type-content"))),
        
        # right: by year
        div(
          h4(class = "mb-4 fw-bold", "Par année"),
          div(id = "election-year-placeholder",
              div(id = "election-year", class = "tag-list"),
              div(id = "election-year-content"))))
    
  )
  
}
