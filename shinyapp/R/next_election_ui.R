
next_election_ui <- function(election){
  
  div(class = "box countdown-box",
      
      # the glow effect!
      div(class="border-glow-mask",
          div(class="border-glow")),
      
      # content
      h2("Prochaine élection"),
      div(icon("arrow-right"), election$title), 
      div(class = "countdown",
          div(class = "countdown-value", as.numeric(difftime(election$date, Sys.Date(), units = "day"))),
          div(class = "countdown-legend", "jours")))
  
}
