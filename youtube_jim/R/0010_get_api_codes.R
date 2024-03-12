#'-----------------
#' get_api_codes
#'-----------------
#'
#' @title get_api_codes
#' @description Returns list of previously configured Google api_key, oauth2 info
#' @details These are created in Google credentials, stored in ~/.Renviron and
#' put into R env system.   This function retrieves from the R environment and
#' returns to code.
#' @return list
#' @export

get_api_codes  <- function() {
  api  <- list(api_key = Sys.getenv("API_KEY"),
               oauth2_id = Sys.getenv("OAUTH2_ID"),
               oauth2_secret = Sys.getenv("OAUTH2_SECRET"))
}

