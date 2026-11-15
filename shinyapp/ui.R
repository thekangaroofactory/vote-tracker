
# ------------------------------------------------------------------------------
# This is the user-interface definition of the Shiny web application.
# ------------------------------------------------------------------------------

# -- Declare theme
app_theme <- bs_theme(
  version = 5,
  #bg = "#2d3037",
  #fg = "#ececec",
  primary = "#c09f7f",
  #secondary = "#ececec",
  base_font = font_google("Quicksand"),
  font_scale = 17/16)


# -- Define application UI
page_navbar(
  
  # -- To observe selected tab
  id = "navbar",
  
  # -- Theme
  theme = app_theme,
  
  # -- Title
  title = "xxx",
  window_title = "xxx",
  
  # -- header
  header = tags$head(),
  
  # -- footer
  fillable = FALSE,
  footer = p(class = "footer", 
             paste("©", format(Sys.Date(), "%Y"), "xxx"), "|",
             actionLink(inputId = "legal_notice", label = "legal notice", class = "ktag")),
  
  
  # ----------------------------------------------------------------------------
  # Tabs (nav_panel)
  # ----------------------------------------------------------------------------
  
  # -- Home
  nav_panel(class = "p-5",
            value = "home",
            title = "Home", 
            
  ),
  
  # -- Spacing
  nav_spacer()
  
)
