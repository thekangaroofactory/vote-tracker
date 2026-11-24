

custom_modal <- function(content = NULL){
  
  # -- component
  tags$div(
    id = "modal-overlay",
    class = "custom-modal-overlay",
    
    tags$div(
      class = "custom-modal-content",
      
      # Close
      tags$button("×", id = "close_modal", class = "custom-close-btn"),
      
      # Placeholder
      div(id = "custom-modal-placeholder", content)
    ))
  
}


custom_modal_show <- function(ui = NULL){
  
  if(is.null(ui))
    return(invisible(NULL))
  
  # insert UI
  insertUI(selector = "#custom-modal-placeholder",
           where = "beforeEnd",
           ui = ui)
  
  # toggle modal
  shinyjs::addClass(id = "modal-overlay", class = "active")
  
}
