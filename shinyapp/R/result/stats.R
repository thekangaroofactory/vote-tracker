

# The UI component
stat_ui <- function(id){
  
  tagList(
    stat_card(id = NS(id, "inscrits"), title = "Inscrits"),
    stat_card(id = NS(id, "votants"), title = "Votants"),
    stat_card(id = NS(id, "abstentions"), title = "Abstentions"),
    stat_card(id = NS(id, "nuls"), title = "Nuls"),
    stat_card(id = NS(id, "blancs"), title = "Blancs"),
    stat_card(id = NS(id, "exprimes"), title = "Exprimés"))
  
}

# The stat card component
stat_card <- function(id, title, icon = "fa-solid fa-angle-right", value = "-", label = ""){
  
  # the component
  div(id = id, class = "stat-card",
      
      # header (icon + title)
      div(class = "stat-header",
          div(class = "icon-wrapper", tags$i(class = icon)),
          span(class = "stat-title", title)),
      
      # body (value + label)
      div(class = "stat-body",
          div(id = paste0(id, "-value"), class = "stat-value", value),
          div(id = paste0(id, "-label"), class = "stat-label", label)))
  
}

# Update all stats
update_stats <- function(values){
  
  shinyjs::html(id = "inscrits-value", values$inscrits)
  shinyjs::html(id = "votants-value", values$votants)
  shinyjs::html(id = "votants-label", paste0("Participation : ", ratio(values$votants, values$inscrits), "%"))
  shinyjs::html(id = "abstentions-value", values$abstentions)
  shinyjs::html(id = "abstentions-label", paste0(ratio(values$abstentions, values$inscrits), "% des inscrits"))
  shinyjs::html(id = "nuls-value", values$nuls)
  shinyjs::html(id = "nuls-label", paste0(ratio(values$nuls, values$votants), "% des votants"))
  shinyjs::html(id = "blancs-value", values$blancs)
  shinyjs::html(id = "blancs-label", paste0(ratio(values$blancs, values$votants), "% des votants"))
  shinyjs::html(id = "exprimes-value", values$exprimes)

}
