
sponsor_ui <- function(){
  
  tagList(
    
    # -- Intro (Hero)
    div(class = "mb-5",
        hero_section(
          title = "Financement",
          subtitle = "Soutenir le développement du projet.")),
    
    
    # -- Section (Project)
    div(class = "mb-5",
        layout_columns(
          col_widths = c(8, 4),
          gap = "2rem",
          
          # Left: text
          div(
            h2(class = "mb-3 fw-bold", "Projet"),
            p("L'objectif du projet est — ", tags$em("à terme"), " — non seulement de proposer un outil de visualisation mais surtout d'analyse des résultats."),
            p("Il fait suite à une 1ère version qui a été consultée par ", strong("+18k visiteurs"), " (dont des équipes de campagne), avec un pic d'activité enregistré en Juin 2024 suite à la dissolution de l'Assemblée Nationale. Ceci démontre le besoin pour ce type d'outil afin de naviguer au travers des millions de lignes de données disponibles."),
            p(class = "mb-0", "Cette nouvelle version est motivée par la mise à disposition de données agrégées par ", tags$em("datagouv"), " et les nouvelles possibilités d'interroger la plateforme via ses APIs.")),
          
          # Right: box
          card(
            class = "box box-effect h-100",
            card_body(
              class = "p-4 d-flex flex-column justify-content-center",
              h3(class = "h4 mb-3 fw-semibold", "Besoins"),
              p(class = "text-sm", "Si les données sont ouvertes en accès libre, les applications qui les consomment ont des besoins à financer :"),
              tags$ul(
                class = "text-sm mb-0 ps-3",
                tags$li(class = "mb-2", "Coûts de", a(href = "#dev", "développement")),
                tags$li("Coûts", a(href = "#infra", "d'infrastructure"))))))),
    
    tags$hr(class = "flag my-5"),
    
    
    # -- Section (support)
    div(class = "mb-5",
        h2(class = "mb-4 fw-bold", "Comment soutenir le projet ?"),
        
        p(class = "mb-4", "Pour passer du stade de prototype / démonstrateur à celui d'application à part entière, le projet doit trouver 
          des sources de financements."),
        
        layout_columns(
          col_widths = c(4, 4, 4),
          gap = "1.5rem",
          
          # Tips
          card(
            class = "box h-100",
            card_body(
              class = "p-4 d-flex flex-column",
              h3(class = "h4 mb-3 fw-semibold", "Tips"),
              p(class = "text-sm flex-grow-1", "Les dons type « pourboires » permettent de soutenir les usages ponctuels."),
              div(class = "mt-3", actionButton("btn_tip", "A venir", class = "btn-outline-dark btn-sm")))),
          
          # Sponsors
          card(
            class = "box h-100",
            card_body(
              class = "p-4 d-flex flex-column",
              h3(class = "h4 mb-3 fw-semibold", "Sponsors"),
              p(class = "text-sm", "Dons sans contrepartie* permettant de financer le développement ouvert du projet."),
              div(class = "mt-3", actionButton("btn_sponsor", "A venir", class = "btn-outline-dark btn-sm")))),
          
          # Services
          card(
            class = "box h-100",
            card_body(
              class = "p-4 d-flex flex-column",
              h3(class = "h4 mb-3 fw-semibold", "Services"),
              p(class = "text-sm flex-grow-1", "Des développements ou analyses spécifiques peuvent être effectués sous forme de services facturés."),
              div(class = "mt-3", actionButton("btn_contact", "Contact", class = "btn-secondary btn-sm"))))),
        
        p(class = "text-muted small fst-italic mt-auto mb-0", "*Sans contrepartie = pas de livrable spécifique au sponsor, sinon il s'agit d'un service.")),
    
    tags$hr(class = "flag my-5"),
    
    
    # -- Section (Infrastructures)
    div(class = "mb-5",
        layout_columns(
          col_widths = c(7, 5),
          gap = "2rem",
          
          div(
            class = "d-flex flex-column justify-content-center",
            h2(id = "infra", class = "mb-3 fw-bold", "Infrastructures"),
            p(class = "mb-0", "À ce stade, le prototype repose sur des infrastructures qui ne permettent pas une utilisation à grande échelle, ni des performances optimales.")),
          
          card(
            class = "box box-effect",
            card_body(
              class = "p-4",
              h3(class = "h5 mb-3 fw-semibold", "Exemples de coûts"),
              tags$ul(
                class = "text-sm mb-0 ps-3",
                tags$li(class = "mb-1", strong("Nom de domaine : "), "8 - 10€ HT/an"),
                tags$li(strong("Hébergement : "), "20 - 50€ HT/mois")))))),
    
    tags$hr(class = "flag my-5"),
    
    
    # -- Section (Features)
    div(class = "mb-4",
        h2(id = "dev", class = "mb-2 fw-bold", "Fonctionnalités"),
        p(class = "mb-4", "Cette liste, non exhaustive, donne des indications sur les fonctionnalités qui peuvent être développées."),
        
        layout_columns(
          col_widths = c(4, 4, 4),
          gap = "1.5rem",
          
          # results
          card(
            class = "box h-100",
            card_body(
              class = "p-4",
              h4(class = "h6 fw-bold mb-3", "Résultats agrégés"),
              tags$ul(
                class = "text-sm mb-0 ps-3",
                tags$li(class = "mb-1", "Au niveau national"),
                tags$li(class = "mb-1", "Au niveau des départements / régions"),
                tags$li("Au niveau des bureaux de vote")))),
          
          # analysis
          card(
            class = "box h-100",
            card_body(
              class = "p-4",
              h4(class = "h6 fw-bold mb-3", "Analyses des écarts"),
              tags$ul(
                class = "text-sm mb-0 ps-3",
                tags$li(class = "mb-1", "Entre les différents niveaux"),
                tags$li(class = "mb-1", "D'une élection à l'autre"),
                tags$li("Entre candidats / listes")))),
          
          # other
          card(
            class = "box h-100",
            card_body(
              class = "p-4",
              h4(class = "h6 fw-bold mb-3", "Outils & Export"),
              tags$ul(
                class = "text-sm mb-0 ps-3",
                tags$li(class = "mb-1", "Téléchargement de rapports d'analyse"),
                tags$li("Besoins spécifiques"))))),
        
        p(class = "text-muted small fst-italic mt-3", 
          "Les coûts de développement sont très variables et dépendent de la complexité des fonctionnalités.")))
  
}