

anime_button <- function(input_id, label, target, namespace){
  
  actionButton(inputId = input_id,
               class = "btn-anime",
               
               # force behavior
               onclick = sprintf("Shiny.setInputValue('%s', '%s', {priority: 'event'});", 
                                 target, namespace),
               
               # so that text is before icon!
               label = tagList(
                 span(class = "btn-texte", label),
                 icon("times")))
  
}
