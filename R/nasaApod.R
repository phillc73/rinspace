# NASA Astronomy Picture of the Day
#
# Example:
# apod <- nasaApod(nasaApiKey = "your_NASA_API_Key", date = "yyyy-mm-dd")
#
# Obtain a NASA API Key here:
# https://api.nasa.gov/index.html#apply-for-an-api-key

nasaApod <- function(nasaApiKey, date = "") {
  reqDate <- paste("&date=", date, sep = "")
  url = "https://api.nasa.gov/planetary/apod?api_key="

  dataReturn <-
    httr::GET(paste(url, nasaApiKey, reqDate, sep = ""))

  if (httr::status_code(dataReturn) != "200") {
    badReturn <-
      jsonlite::fromJSON(httr::content(dataReturn,type = "text"))
    stop(
      "\nSomething went wrong. Please check the function options to ensure valid values. \n",
      "\nStatus Code: ", badReturn$code, "\nMessage: ", badReturn$message
    )

  } else {
    # Output as dataframe
    jsonlite::fromJSON(httr::content(dataReturn, type = "text"))
  }
}
