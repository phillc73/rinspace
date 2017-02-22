# NASA Near Earth Object Lookup
# Browse the overall Asteroid data-set
#
# Example:
# neolookup <- nasaNeoLookup(asteroidId = "2315020")
#
# This function defaults to using the NASA DEMO_KEY.
#
# Obtain your own NASA API Key here:
# https://api.nasa.gov/index.html#apply-for-an-api-key

nasaNeoLookup <- function(nasaApiKey = "DEMO_KEY", asteroidId) {

  url = "https://api.nasa.gov/neo/rest/v1/neo/"
  nasaApiKey = paste("?api_key=", nasaApiKey, sep = "")

  dataReturn <-
    httr::GET(paste(url, asteroidId, nasaApiKey, sep = ""))

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
