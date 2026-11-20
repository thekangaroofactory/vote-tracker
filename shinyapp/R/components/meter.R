
meter <- function(title, min = 0, max = 100, value = 0){

  div(class="meter-container",
      tags$label(class = "meter-label", title),
      
      div(class = "meter-row",
          div(
            class = "meter-track",
            role = "progressbar",
            `aria-valuenow` = value,
            `aria-valuemin` = min,
            `aria-valuemax` = max,
            div(id = "my_custom_bar", class = "meter-fill")),
          span(class = "meter-value", paste(value, "%"))))
  
}
