

hero_section <- function(title, subtitle = NULL, ..., close = FALSE){
  
  div(class = "hero-section",
      
      # conditional button
      if(close)
        div(
          class = "hero-btn-right",
          button("Fermer")),
      
      # title & subtitle
      h1(class = "hero-title", HTML(title)),
      if(!is.null(subtitle)) p(class = "hero-subtitle", subtitle),
      
      # other content
      ...
      
  )
  
}
