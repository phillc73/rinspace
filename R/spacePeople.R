# People in Space
# How many humans are in space right now?
#
# Example:
# spacePeople <- spacePeople()

spacePeople <- function() {

  url = "http://api.open-notify.org/astros.json"

  dataReturn <-
    httr::GET(url)

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
