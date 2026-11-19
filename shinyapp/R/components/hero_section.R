

hero_section <- function(title, subtitle = NULL){

  div(class = "hero-section", 
      h1(class = "hero-title", HTML(title)),
      if(!is.null(subtitle)) p(class = "hero-subtitle", subtitle)
      )
  
}
