
# Functions to manage candidate results
# -------------------------------------

# Note: because candidates may vary from a commune to another (for local 
# elections), rows will be inserted into the container once the search
# result is clicked.


# The candidate list (container)
cand_ui <- function(namespace){
  
  div(id = NS(namespace, "cand-list"),
      class = "cand-grid indented mt-5")
  
}


# Candidate row
cand_row <- function(name, voix, ratio){
  
  # the row
  div(class = "cand-row",
      
      # left (candidate name)
      h4(class = "cand-row-name", name),
      
      # middle (meter)
      div(
        meter_point(value = ratio),
        div(class = "cand-row-legend", voix, "voix")),
      
      # right (%)
      div(class = "cand-row-value", paste0(ratio, "%"))
      
  )
  
}

meter_point <- function(value, min = 0, max = 100){
  
  div(class = "meter-track",
      role = "progressbar",
      `aria-valuenow` = value,
      `aria-valuemin` = min,
      `aria-valuemax` = max,
      
      div(class = "meter-point slide-in")) # style = paste0("margin-left: ", value, "%;")
  
}
