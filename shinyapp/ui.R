
# ------------------------------------------------------------------------------
# This is the user-interface definition of the Shiny web application.
# ------------------------------------------------------------------------------

# -- Declare theme
app_theme <- bs_theme(
  version = 5,
  bg = "#bea795",
  fg = "#000",
  primary = "#654F3E",
  secondary = "#ff8044",
  base_font = font_google("Zen Maru Gothic"),
  font_scale = 17/16)

# -- Define application UI
page_navbar(
  
  # -- To observe selected tab
  id = "navbar",
  
  # -- Theme
  theme = app_theme,
  
  # -- Title
  title = "voteTracker",
  window_title = "voteTracker",
  
  # -- header
  header = tags$head(
    
    # CSS
    tags$link(rel = "stylesheet", type = "text/css", href = "./css/vote-tracker.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "./css/hero.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "./css/meter.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "./css/components.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "./css/stats.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "./css/candidates.css"),
    
    # JavaScript
    shinyjs::useShinyjs(),
    tags$script(src = "./js/meter.js"),
    tags$script(src = "./js/candidates.js"),

  ),
  
  # -- footer
  fillable = FALSE,
  footer = p(class = "footer", 
             paste("©", format(Sys.Date(), "%Y"), "voteTracker"), "|",
             actionLink(inputId = "legal_notice", label = "mentions légales", class = "ktag")),
  
  
  # ----------------------------------------------------------------------------
  # Tabs (nav_panel)
  # ----------------------------------------------------------------------------
  
  # -- Home
  nav_panel(class = "vt-tab p-5",
            value = "home",
            title = "Accueil", 
            
            # -- intro
            hero_section(title = paste0("vote", span(class = "text-secondary", "T", .noWS = "outside"), "racker"),
                         subtitle = "Visualiser les résultats des éléctions."),
            
            p("L'application présente les résultats des élections françaises à partir des données publiées 
              par le Ministère de l'Intérieur et des Outre-mer, agrégées par la plateforme", 
              a(href = "https://www.data.gouv.fr/", target = "_blank", "datagouv"), ".", br(),
              "Elle n'est affiliée à aucun organisme public ni parti politique. Pour soutenir son développement [xxx]"),
            
            
            # -- next election
            div(id = "next-election-placeholder"),

            
            # -- dataset
            h2(class = "mb-3", "Données"),
            p("Les données utilisées par l'outil sont mises à jour automatiquement lorsque", tags$em("datagouv"),
              "publie une nouvelle version.", br(),
              "Pour en savoir plus sur les sources de données et leur gestion, clickez",
              a(href = "#", 
                onclick = "Shiny.setInputValue('switch_tab', 'data', {priority: 'event'});",
                "ici.")),
            div(id = "dataset-meta", class = "box-fit text-sm"),
            
            
            # -- nb elections
            div(class = "mt-4 mb-3",
                h2("Résultats"),
                div(id = "election-summary-placeholder")),

            # -- results (columns)
            div(class = "side-by-side",
                
                # left: by types
                div(
                  h3(class = "mb-3", "Par type"),
                  div(id = "election-type-placeholder",
                      div(id = "election-type", class = "tag-list"),
                      div(id = "election-type-content"))),
                
                # right: by year
                div(
                h3(class = "mb-3", "Par année"),
                div(id = "election-year-placeholder",
                    div(id = "election-year", class = "tag-list"),
                    div(id = "election-year-content"))))
            
  ),
  
  
  # -- data
  nav_panel(class = "vt-tab p-5",
            value = "data",
            title = "Données",
            
            # -- intro
            hero_section(title = "Données",
                         subtitle = "Sources et gouvernance."),
            
            span(class = "loader"),
            
            div(class = "side-by-side mt-4",
                
                div(class = "box text-sm box-effect",
                    h3(class = "mb-3", "Résultats"),
                    p("Le jeu de données principal est fourni par", tags$em("datagouv"), "et s'intitule", 
                      tags$em(tags$strong("« Données des élections agrégées »."))),
                    p("Il contient deux fichiers agrégés au niveau des bureaux de vote :",
                      tags$ul(
                        tags$li("Résultats généraux"),
                        tags$li("Résultats par candidat")),
                      "Dans les deux cas, le format parquet est utilisé."),
                    a(href = "https://www.data.gouv.fr/datasets/donnees-des-elections-agregees",
                      target = "_blank",
                      "Source")),
                
                div(class = "box text-sm box-effect",
                    h3(class = "mb-3", "Datamarts"),
                    p("A partir du fichier des résultats généraux, deux agrégats sont réalisés :",
                      tags$ul(
                        tags$li("Sommaire des élections"),
                        tags$li("Liste des communes par élection")),
                      "Cela permet de fluidifier la navigation, la recherche et de ne pas recalculer les chiffres globaux 
                      comme la participation.")),
                
                div(class = "box text-sm box-effect",
                    h3(class = "mb-3", "Contours"),
                    p("Les contours des communes (affichés sur la carte) sont récupérés via l'API",
                    tags$em(tags$strong("« Découpage Administratif »")), "de", tags$em("datagouv.")),
                    p("Pour les villes étrangères (ambassades, consulats), une boîte est récupérée depuis l'API",
                      tags$em(tags$strong("« Nominatim »")), "d'OpenStreetMap."),
                    p("Cette opération est faite à la demande (c'est à dire quand une commune est sélectionnée),",
                      "puis les contours sont conservés dans un cache pour limiter les appels."),
                    a(href = "https://www.data.gouv.fr/dataservices/api-decoupage-administratif-api-geo",
                      target = "_blank",
                      "Source")))
            
  ),
  
  
  # -- data
  nav_panel(class = "vt-tab p-5",
            value = "project",
            title = "Soutenir",
            
            # -- intro
            hero_section(title = "Financement",
                         subtitle = "Soutenir le développement du projet."),
            
            div(class = "side-by-side box-dyn-cont mt-4",
                
                div(class = "box box-dyn-item text-sm box-effect",
                    h3(class = "mb-3", "Projet"),
                    p("L'objectif du projet est — à terme — non seulement de proposer un outil de visualisation mais 
                  surtout d'analyse des résultats."),
                    p("Il fait suite à une 1ère version qui a été consultées par +18k visiteurs (dont des équipes de campagne), 
                    avec un pic d'activité enregistré en Juin 2024 suite à la dissolution de l'Assemblée Nationale. Ce qui démontre 
                    le besoin pour ce type d'outil afin de naviguer au travers des millions de lignes de données disponibles."),
                    p("Cette nouvelle version est motivée par la mise à disposition de données agrégées par", tags$em("datagouv"),
                      "et les nouvelles possibilités d'intéroger la plateforme via ses APIs.")),
                
                div(class = "box box-dyn-item text-sm box-effect",
                    h3(class = "mb-3", "Besoins"),
                    p("Si les données sont ouvertes en accès libre, les applications qui les consomment ont des besoins à financer :"),
                    tags$ul(
                      tags$li("Coûts de développement"),
                      tags$li("Coûts d'infrastructure"))),
                
                div(class = "box box-dyn-item text-sm box-effect",
                    h3(class = "mb-3", "Financement"),
                    p("Pour offrir des performances optimales et proposer d'avantage de fonctionalités..."))),
            
            h2("Infrastructures"),
            p("A ce stade, le prototype repose sur des infrastructures qui ne permettent pas des performances optimales.", br(),
              "Par exemple, [compute time to retrieve communes or specific result & compare with local]"),
            
            h3("Exemples de coûts"),
            tags$ul(
              tags$li("Nom de domaine : 8 - 10€ HT/an"),
              tags$li("Hébergement : 20 - 50€ HT/mois")),
            
            h2("Fonctionalités"),
            p("Cette liste, non exhaustive, donne des indications sur les fonctionalités qui peuvent être développées 
              sur la base de ce prototype."),
            tags$ul(
              tags$li("Résultats agrégés au niveau des départements / régions"),
              tags$li("Résultats agrégés au niveau national"),
              tags$li("Résultats au niveau des bureaux de vote"),
              tags$li("Analyse des écarts de performances entre les différents niveaux"),
              tags$li("Analyse des écarts de performances d'une élection à l'autre"),
              tags$li("Analyse des écarts de performances entre candidats / listes"),
              tags$li("Téléchargement de rapports d'analyse"),
              tags$li("Besoins spécifiques")),
            p("Les coûts de développement sont très variables et dépendent de la complexité des fonctionalités."),
            
            h2("Comment soutenir le projet ?"),
            p("xxx"),
            
            div(class = "side-by-side mt-4",
                
                div(class = "box text-sm",
                    h3(class = "mb-3", "Tips"),
                    p("Les dons type 'pourboirs' permettent de soutenir les usages ponctuels. 
                      ex: nom de domaine.")),
                
                div(class = "box text-sm",
                    h3(class = "mb-3", "Sponsors"),
                    p("Dons sans contre-partie* permettant de financer le développement ouvert du projet."),
                    p("Sans contre-partie = pas de livrable spécifique au sponsor, sinon il s'agit d'un service.")),
                
                div(class = "box text-sm",
                    h3(class = "mb-3", "Services"),
                    p("Des développements ou analyses spécifiques peuvent être effectués sous forme de services facturés.")))
            
  ),
  
  
  # -- Spacing
  nav_spacer()
  
)
