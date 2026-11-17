

contour_commune <- function(code){

  # init
  # pattern: https://geo.api.gouv.fr/communes/39300?fields=contour&format=geojson&geometry=contour
  base <- "https://geo.api.gouv.fr"
  endpoint <- "communes"
  
  # query params
  param <- list(fields = "contour",
                format = "geojson",
                geometry = "contour")

  # build url
  url <- paste(base, endpoint, code, sep = "/")
  
  # Query parameters
  param <- paste(names(param), param, sep = "=", collapse = "&")
  url <- paste(url, param, sep = "?")
  
  # call API
  res <- iker::with_cache(
    iker::call_api(url, header = list()),
    timeout = 24,
    encrypt = FALSE)

  # return
  if(res$status_code == 200)
    jsonlite::fromJSON(res$content)
  else NULL

}
