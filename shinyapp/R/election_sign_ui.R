
election_sign_ui <- function(election, incoming = TRUE){
  
  div(class = "box box-effect",
      
      # the glow effect!
      div(class="border-glow-mask",
          div(class="border-glow")),
      
      # content
      h4(class = "mb-3 fw-semibold", ifelse(incoming, "Prochaine", "Dernière"), "élection"),
      div(icon("arrow-right"), election$title), 
      div(class = "countdown",
          div(class = "countdown-value", abs(as.numeric(difftime(election$date, Sys.Date(), units = "day")))),
          div(class = "countdown-legend", "jours")))
  
}
