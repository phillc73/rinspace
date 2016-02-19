# NASA Space Sound Archive
# Sound exists in space. Sometimes.
#
# Note that the download URLs in the returned object require soundcloud authentication to access the files.
# This will likely change in the stable version of the API.
#
# Example:
# sounds <- nasaSounds(query = "apollo", nasaApiKey = "DEMO_KEY")
#
# Obtain a NASA API Key here:
# https://api.nasa.gov/index.html#apply-for-an-api-key

nasaSounds <- function(query = "", limit = "10", nasaApiKey) {

  url = "https://api.nasa.gov/planetary/sounds?"
  query = paste("query=", query, sep = "")
  limit = paste("&limit=", limit, sep = "")
  nasaApiKey = paste("&api_key=", nasaApiKey, sep = "")

  dataReturn <-
    httr::GET(paste(url, query, limit, nasaApiKey, sep = ""))

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
