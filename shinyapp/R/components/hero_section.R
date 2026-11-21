

hero_section <- function(title = "", subtitle = "", namespace = NULL, close = FALSE, ...){
  
  ns <- NS(namespace)
  
  div(class = "hero-section",
      
      # conditional button
      if(close)
        div(
          class = "hero-btn-right",
          anime_button(input_id = ns("btn_close"), label = "Fermer", target = "close_tab", namespace = namespace)),
      
      # title & subtitle
      h1(id = ns("hero-title"), class = "hero-title", HTML(title)),
      p(id = ns("hero-subtitle"), class = "hero-subtitle", subtitle),
      
      # other content
      ...
      
  )
  
}
