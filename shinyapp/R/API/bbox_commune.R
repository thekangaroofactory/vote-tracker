
#' Bounding Box
#' 
#' @description
#' Get the bounding box from Nominatim API.
#'
#' @param name the name / address to look for.
#'
#' @returns a sf object.
#' @export
#'
#' @examples
#' bbox_commune("chicago")

bbox_commune <- function(name){
  
  stopifnot(is.character(name))
  
  # call to Nominatim API
  res <- kmaps::geocode(name)
  
  # extract bounding box
  raw_coords <- as.numeric(unlist(res$boundingbox))
  
  # Reorder from c(ymin, ymax, xmin, xmax) to c(xmin, ymin, xmax, ymax)
  # because sf assumes a different one from Nominatim
  bbox_vec <- c(
    xmin = raw_coords[3],
    ymin = raw_coords[1],
    xmax = raw_coords[4],
    ymax = raw_coords[2])
  
  # return bounding box as sf object
  st_bbox(bbox_vec, crs = 4326) |>
    st_as_sfc() |>
    st_sf()
  
}
