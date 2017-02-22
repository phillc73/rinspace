# NASA Mars Rover Photos
# Sound exists in space. Sometimes.
#
# Note that the download URLs in the returned object require soundcloud authentication to access the files.
# This will likely change in the stable version of the API.
#
#
# Examples:
# marsRovers <- nasaMarsRovers(rover = "spirit", earthDate = "2006-10-27",
#                              camera = "pancam")
#
# marsRovers <- nasaMarsRovers(rover = "curiosity", sol = "1000",
#                              camera = "rhaz")
#
#marsRovers <- nasaMarsRovers(rover = "opportunity", sol = "10",
#                             page = "5")
#
# This function defaults to using the NASA DEMO_KEY.
#
# Obtain your own NASA API Key here:
# https://api.nasa.gov/index.html#apply-for-an-api-key

nasaMarsRovers <-
  function(rover, sol = NULL, earthDate = NULL, camera = NULL, page = "1", nasaApiKey = "DEMO_KEY") {
    `%notin%` <- function(x,y)
      ! (x %in% y)

    if (!is.null(camera) == TRUE) {
      if (rover == "opportunity" |
          rover == "spirit" &&
          camera %notin% c("fhaz", "rhaz", "navcam", "pancam", "minites") == TRUE) {
        stop(
          "\nYou have not chosen a valid camera for Opportunity or Spirit rover.\n",
          "\nValid cameras are: fhaz, rhaz, navcam, pancam and minites"
        )
      }

      if (rover == "curiosity" &&
          camera %notin% c("fhaz", "rhaz", "mast", "chemcam", "mahli", "mardi", "navcam") == TRUE) {
        stop(
          "\nYou have not chosen a valid camera for Curiosity rover.\n",
          "\nValid cameras are: fhaz, rhaz, mast, chemcam, mahli, madri and navcam"
        )
      }
    }

    if (!is.null(sol) == TRUE & !is.null(earthDate) == TRUE) {
      stop(
        "\nBoth sol (Martian day) and earthDate have been entered.\n",
        "\nOnly one may be chosen. Please try again."
      )
    }

    if (is.null(sol) == TRUE & is.null(earthDate) == TRUE) {
      stop(
        "\nNeither sol (Martian day) nor earthDate have been entered.\n",
        "\nOne must be chosen. Please try again."
      )
    }

    if (!is.null(sol) == TRUE) {
      date = paste("sol=", sol, sep = "")
    } else {
      date = paste("earth_date=", earthDate, sep = "")
    }

    url = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
    page = paste("&page=", page, sep = "")
    nasaApiKey = paste("&api_key=", nasaApiKey, sep = "")

    if (!is.null(camera) == TRUE) {
      camera = paste("&camera=", camera, sep = "")
      dataReturn <-
        httr::GET(paste(url, rover, "/photos?", date, camera, page, nasaApiKey, sep = ""))
    } else {
      dataReturn <-
        httr::GET(paste(url, rover, "/photos?", date, page, nasaApiKey, sep = ""))
    }

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
