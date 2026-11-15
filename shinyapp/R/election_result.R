

election_result <- function(data){
  
  # prepare
  type <- election_mapping |> filter(type == data$election_type) |> pull("title")
  
  # return ui
  div(
    h2("Élection", type, data$election_year, paste0("(", toupper(data$election_tour), ")")),
    
    p(paste0("Participation : ", data$ratio_votants_inscrits, "%"), br(),
      paste0("Abstention : ", data$ratio_abstentions_inscrits, "%"))
  )
    
}
