
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
    tags$link(rel = "stylesheet", type = "text/css", href = "./css/custom_modal.css"),
    
    # JavaScript
    shinyjs::useShinyjs(),
    tags$script(src = "./js/meter.js"),
    tags$script(src = "./js/candidates.js"),
    tags$script(src = "./js/custom_modal.js"),
    tags$script(src = "./js/loader.js"),
    
    # -- implement modal window
    # so that it's available across the app
    custom_modal(),

    # the top loader
    div(class="top-loader")
    
  ),
  
  # -- footer
  fillable = FALSE,
  footer = p(class = "footer", 
             paste("©", format(Sys.Date(), "%Y"), "voteTracker"), "|",
             actionLink(inputId = "legal_notice", label = "mentions légales")),
  
  
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
            
            data_ui()),
  
  
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
