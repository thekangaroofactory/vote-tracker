

anime_button <- function(input_id, label){
  
  actionButton(inputId = input_id,
               class = "btn-anime",
               
               # so that text is before icon!
               label = tagList(
                 span(class = "btn-texte", label),
                 icon("times")))
  
}
