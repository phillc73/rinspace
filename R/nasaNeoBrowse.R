# NASA Near Earth Object Browse
# Browse the overall Asteroid data-set
#
# Example:
# neobrowse <- nasaNeoBrowse(nasaApiKey = "DEMO_KEY")
#
# Obtain a NASA API Key here:
# https://api.nasa.gov/index.html#apply-for-an-api-key

nasaNeoBrowse <- function(nasaApiKey) {

  url = "https://api.nasa.gov/neo/rest/v1/neo/browse?"
  nasaApiKey = paste("&api_key=", nasaApiKey, sep = "")

  dataReturn <-
    httr::GET(paste(url, nasaApiKey, sep = ""))

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
