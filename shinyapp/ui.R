
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
    
    tags$link(rel = "stylesheet", type = "text/css", href = "./css/vote-tracker.css"),
    
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
            
            h1("voteTracker"),
            p("L'application présente les résultats des éléctions françaises à partir des données publiées sur data.gouv.fr")
            
  ),
  
  # -- Spacing
  nav_spacer()
  
)
