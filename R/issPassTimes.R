# ISS Pass Time
# When will the ISS be overhead?
#
# Example:
# issPassTimes <- issPassTimes(lat = "-14.31", lon = "11.50", alt = "500", passes = "5")

issPassTimes <- function(lat, lon, alt = "", passes = "") {

  url = "http://api.open-notify.org/iss-pass.json?"
  lat = paste("lat=", lat, sep = "")
  lon = paste("&lon=", lon, sep = "")
  alt = paste("&alt=", alt, sep = "")
  passes = paste("&n=", passes, sep = "")

  dataReturn <-
    httr::GET(paste(url, lat, lon, alt, passes, sep = ""))

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
