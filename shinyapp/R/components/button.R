

button <- function(label){
  
  actionButton(inputId = "btn_close",
               class = "btn-anime",
               label = tagList( # so that text is before icon!
                 span(class = "btn-texte", label),
                 icon("times")))
  
}
