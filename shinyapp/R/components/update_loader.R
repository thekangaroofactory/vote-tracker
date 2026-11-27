
update_loader <- function(value = 0, session = getDefaultReactiveDomain()){
  
  session$sendCustomMessage("updateLoader", list(value = value))
  
}
