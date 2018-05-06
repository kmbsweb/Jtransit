#' Get the transit data
#'
#' @param origin character of place name
#' @param destination character of place name
#' @param st_timeh time houre numeric
#' @param st_time2 time minutes numeric
#' @param st_time1 time minutes numeric
#'
#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes
#' @importFrom rvest html_text
#'
#' @examples
#' \dontrun{
#' # from Kobe university to Osaka station departure:12:20
#' # Jpanese character only
#' transit(Kobe university, Osaka station, 12, 2, 0)
#' }
#'
#' @export
#'
#' @author Keigo Matsuo \email{m.keigo.sp.ku@@gmail.com}
#'
transit <- function(origin,destination,st_timeh,st_time2,st_time1){

  #extract
  extract <- paste0("https://transit.yahoo.co.jp/search/result?flatlon=&from=", origin, "&tlatlon=&to=", destination,
                    "&hh=", st_timeh, "&m2=", st_time1,"&m1=", st_time2)
  extract <- read_html(extract)
  #get travel time
  time <- extract %>% html_nodes("span.small") %>% html_text()

  #get fare
  Unchin <- extract %>% html_nodes("li.fare") %>%
    html_text() %>% as.character

  #extract times of transfer
  Norikae <- extract %>% html_nodes("li.transfer") %>% html_text() %>%
    as.character()

  #extract a number of roots
  Result <- extract %>% html_nodes(xpath = "//dt//span[@class = 'bold']") %>%
    html_text() %>% unique()

  MasterData <- data.frame(time[1],Unchin[1],Norikae[1],Result[1])
  stiation <- data.frame(c(paste0(origin)),c(paste0(destination)),c(paste0(st_timeh)),
                         c(paste0(st_time2)),c(paste0(st_time1)))
  MasterData <- cbind(stiation, MasterData)
  colnames(MasterData) <- c("origin","destination","time_h","time_m1","time_m2",
                            "duration","fare","transit","alternative")
  return(MasterData)
}
