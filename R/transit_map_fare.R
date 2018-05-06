#' mapping fare
#'
#' @param orlon map center longitude
#' @param orlat map center latitude
#' @param zoom ggmap zoom
#' @param data data.frame including longitude,latitude,fare
#'
#' @importFrom ggmap get_googlemap
#' @importFrom ggmap ggmap
#' @importFrom ggplot2 geom_point
#' @importFrom ggplot2 scale_color_gradient
#'
#' @examples
#' \dontrun{
#' # from Kobe university to Osaka station departure:12:20
#' # center:Kobe University
#' transit.map.fare(135.235395,34.725918,11,Data)
#' }
#'
#' @export
#'
#' @author Keigo Matsuo \email{m.keigo.sp.ku@@gmail.com}
#'
transit_map_fare <- function(orlon,orlat,zoom,data){
  library(ggmap)
  nyc_map <- get_googlemap(center = c(lon =orlon, lat = orlat),
                           zoom = zoom, scale = 2, color="bw" )
  ggmap(nyc_map, legend="none") +
    geom_point(aes(longitude, latitude, color= fare),data = data)+
    scale_color_gradient(low="yellow",high="red")
}

#' mapping fare
#'
#' @param orlon map center longitude
#' @param orlat map center latitude
#' @param zoom ggmap zoom
#' @param data data.frame including longitude,latitude,fare
#'
#' @importFrom ggmap get_googlemap
#' @importFrom ggmap ggmap
#' @importFrom ggplot2 geom_point
#' @importFrom ggplot2 scale_color_gradient
#'
#' @examples
#' \dontrun{
#' # from Kobe university to Osaka station departure:12:20
#' # center:Kobe University
#' transit.map.dura(135.235395,34.725918,11,Data)
#' }
#'
#' @export
#'
#' @author Keigo Matsuo \email{m.keigo.sp.ku@@gmail.com}
#'
# mapping duration
transit_map_dura <- function(orlon, orlat, zoom, data){
  library(ggmap)
  nyc_map <- get_googlemap(center = c(lon =orlon, lat = orlat),
                           zoom = zoom, scale = 2, color="bw" )
  ggmap(nyc_map, legend="none") +
    geom_point(aes(longitude, latitude, color= duration),data = data)+
    scale_color_gradient(low="yellow",high="red")
}
