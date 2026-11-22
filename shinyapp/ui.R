
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
              "Pour en savoir plus sur les sources de données et leur gestion, clicker ici."),
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
  
  # -- Spacing
  nav_spacer()
  
)
