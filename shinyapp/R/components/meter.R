
# The component
meter <- function(id, title, min = 0, max = 100, value = 0){

  div(id = id,
      class="meter-container",
      tags$label(class = "meter-label", title),
      
      div(class = "meter-row",
          div(
            class = "meter-track",
            role = "progressbar",
            `aria-valuenow` = value,
            `aria-valuemin` = min,
            `aria-valuemax` = max,
            div(id = paste0(id, "-bar"), class = "meter-fill")),
          span(id = paste0(id, "-value"), class = "meter-value", paste(value, "%"))))
  
}

# The function to update the component
update_meter <- function(id, value) {
  session$sendCustomMessage("updateMeter", list(id = id, value = value))
}
