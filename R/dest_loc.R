#' facility geocoding
#'
#' @param data data.frame
#' @param x colm number colname must be "location"
#'
#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes
#' @importFrom xml2 xml_find_all
#' @importFrom rvest html_text
#' @importFrom base paste0
#' @importFrom dplyr full_join
#'
#' @examples
#' \dontrun{
#' # geocoding
#' # Jpanese character only
#' # colm name must be "location"
#' location <- c("Kobe university","Koshien studiam")
#' dataD <- data.frame(location=location)
#' dest.loc(dataD,1)
#' # result
#' #location latitude longitude
#' #Kobe University 34.72562  135.2354
#' #Kosien studiam 34.72129  135.3616
#' }
#'
#' @export
#'
#' @author Keigo Matsuo \email{m.keigo.sp.ku@@gmail.com}
#'
dest_loc <- function(data,x){

  H <- as.character(data[,x])

  Mastergeo_SA <- data.frame()

  for(i in H){
    geo_url <- paste0("http://www.geocoding.jp/api/?v=1.1&q=", i)
    dataa <- getURL(geo_url, ssl.verifypeer = FALSE)

    #retrieve as XML

    geodata <- read_xml(dataa)

    #extract elements
    location <- as.character(xml_text(xml_find_all(geodata, "//google_maps")))
    #latitude
    latitude <- xml_text(xml_find_all(geodata, "//lat"))
    latitude <- as.numeric(latitude)
    #longitude
    longitude <- xml_text(xml_find_all(geodata, "//lng"))
    longitude <- as.numeric(longitude)
    #merge1
    GetData <- data.frame(location, latitude, longitude)
    #merge2
    Mastergeo_SA <- rbind(Mastergeo_SA, GetData)
  }
  #full join
  fdata <-dplyr::full_join(data , Mastergeo_SA ,by="location")
  return(fdata)
}
