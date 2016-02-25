# Burning Soul Moon Data
# What's the moon look like now?
#
# API Info:
# http://www.burningsoul.in/apis/moon
# https://github.com/burningsoul/API-CLIENT/wiki/MOON
#
# Example:
# timeNow <- as.numeric(as.POSIXct(Sys.time()))
# moonData <- moonData(timestamp = timeNow)

moonData <- function(timestamp = "1456419245") {

  url = "http://api.burningsoul.in/moon"
  timestamp = paste("/", timestamp, sep = "")

  dataReturn <-
    httr::GET(paste(url, timestamp, sep = ""), user_agent("Mozilla/5"))

  if (httr::status_code(dataReturn) != "200") {
    stop(
      "\nSomething went wrong. Please check the function options to ensure valid values. \n",
      "\nStatus Code: ", httr::status_code(dataReturn)
    )

  } else {
    # Output as dataframe
    jsonlite::fromJSON(httr::content(dataReturn, type = "text"))
  }
}
