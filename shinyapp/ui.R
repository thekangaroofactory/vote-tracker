
# ------------------------------------------------------------------------------
# This is the user-interface definition of the Shiny web application.
# ------------------------------------------------------------------------------

# -- Declare theme
app_theme <- bs_theme(
  version = 5,
  bg = "#b59a85",
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
    
    # JavaScript
    shinyjs::useShinyjs(),
    
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
  nav_panel(class = "p-5",
            value = "home",
            title = "Accueil", 
            
            # intro
            h1("vote", span(class = "text-secondary", "T", .noWS = "outside"), "racker"),
            p("L'application présente les résultats des élections françaises à partir des données publiées 
              par le Ministère de l'Intérieur et des Outre-mer, agrégées sur la plateforme", 
              a(href = "https://www.data.gouv.fr/", target = "_blank", "datagouv"), ".", br(),
              "Les données sont intérogées en temps réel, de sorte que la dernière mise à jour est reflétée à tout moment."),
            
            # dataset
            div(id = "dataset-meta"),
            div(id = "election-summary-placeholder"),

            # by types            
            h2("Par type"),
            div(id = "election-type-placeholder",
                div(id = "election-type"),
                div(id = "election-type-content")),
            
            # by year
            h2("Par année"),
            div(id = "election-year-placeholder")
            
  ),
  
  # -- Spacing
  nav_spacer()
  
)
