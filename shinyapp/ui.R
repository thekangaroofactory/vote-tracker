
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
            
            home_ui()),
  
  
  # -- data
  nav_panel(class = "vt-tab p-5",
            value = "data",
            title = "Données",
            
            # -- intro
            hero_section(title = "Données",
                         subtitle = "Sources et gouvernance."),
            
            # key figure
            div(class = "text-em",
              span(class = "countdown text-secondary", "30"), " Millions de lignes"),
            span(class = "loader"),
            
            # details
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
            
            sponsor_ui()),
  
  
  # -- Spacing
  nav_spacer(),
  
  # linkedin
  nav_item(
      a(id = "linkedin",
        class = "nav-link",
        href = "https://www.linkedin.com/in/philippeperet/",
        target = "_blank",
        icon("linkedin", class = "fa-xl")))
  
)
