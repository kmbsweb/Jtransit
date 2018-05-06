#' converting unit(from hour to minute)
#'
#' @param data data.frame including jikan hun that is japanese charctor
#' @param x data.frame colm number including jikan hun
#'
#' @importFrom stringr str_detect
#' @importFrom tidyr separate
#' @importFrom utils type.convert
#' @examples
#' \dontrun{
#' # converting "y hour yy minutes" to "zz minutes"
#' # Jpanese character only
#' time    <- c("1h20m","43m","20m","22m")
#' or <- c("kobe","osaka","kyoto","shiga")
#' dataF <- data.frame(origin=or,time=time)
#'
#' # result
#' DD <- covert_m(dataF,2)
#' }
#'
#' @export
#'
#' @author Keigo Matsuo \email{m.keigo.sp.ku@@gmail.com}
#'
covert_m <- function(data,x){

  data$new <- ifelse(stringr::str_detect(data[,x],"h")==TRUE, paste(dataF[,x]) , paste("0h",dataF$time))

  Time <- data %>%
  tidyr::separate(new,c("hour", "minute"),"h")%>%
  tidyr::separate(minute,c("minute", "sum"),"m")

  Time$hour <- type.convert(Time$hour)
  Time$minute <- type.convert(Time$minute)
  Time$sum <- Time$hour*60+Time$minute

  sum.minute <- data.frame(data,Time$sum)

  return(sum.minute)
}
