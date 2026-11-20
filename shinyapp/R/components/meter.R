
meter <- function(title, min = 0, max = 100, value = 0){

  div(class="progress-container",
      tags$label('for' = "avancement", class = "progress-label", title),
      
      div(class = "progress-row",
          div(
            class = "shiny-progress-track",
            role = "progressbar",
            `aria-valuenow` = value,
            `aria-valuemin` = min,
            `aria-valuemax` = max,
            div(id = "my_custom_bar", class = "shiny-progress-fill")),
          span(class = "progress-value", paste(value, "%"))))
  
}
