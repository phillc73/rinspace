# NASA Near Earth Object Feed
# Retrieve a list of Asteroids based on their closest approach date to Earth.
#
# Example:
# neofeed <- nasaNeoFeed(startDate = "yyyy-mm-dd")
# Parameter endDate defaults to seven days after startDate and cannot be more than seven days later.
#
# This function defaults to using the NASA DEMO_KEY.
#
# Obtain your own NASA API Key here:
# https://api.nasa.gov/index.html#apply-for-an-api-key

nasaNeoFeed <- function(nasaApiKey = "DEMO_KEY", startDate, endDate = "") {

  url = "https://api.nasa.gov/neo/rest/v1/feed?"
  startDate = paste("start_date=", startDate, sep = "")
  endDate = paste("&end_date=", endDate, sep = "")
  nasaApiKey = paste("&api_key=", nasaApiKey, sep = "")

  dataReturn <-
    httr::GET(paste(url, startDate, endDate, nasaApiKey, sep = ""))

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


