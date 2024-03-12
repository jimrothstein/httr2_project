#'-----------------
#' initialize
#'-----------------
#' @title initialize 
#' @description sets up and configures global params 
#' @details these are created in google credentials, stored in ~/.renviron and
#' put into r env system.   this function retrieves from the r environment and
#' returns to code.
#' @return list
#' @export
initialize <- function() {
##  gather all global params

## get google token
## todo  - add code to create the token, if needed.

  file  <- "~/code/youtube_api/.httr-oauth"
  if ( file.exists(file)) {
    token  <- readRDS(file)[[1]]
  } else {
    stop("Please create auth.code first")
  }  

  
## To avoid carrying this around:
  config <- httr::config(token = token)

## prep for GET
  if (!exists("api")) api <- get_api_codes()


## package params  
  global_params  <- structure(list(config = config,
                       api = api),
                       class = "global_params")
}


#'-----------------
#' query_params 
#'-----------------
#' @title query_params 
#' @description sets up and configures params specific to type of query 
#' @details these are created in google credentials, stored in ~/.renviron and
#' put into r env system.   this function retrieves from the r environment and
#' returns to code.
#' @return list
#' @export
#'
#'
#' @note
#' # FUTURE:   Depending on class (or query pupose), different defaults, urls
#' etc may be used.   Omit for now.  Do it downstream.
query_params  <- function(url = NULL, part = NULL, fields = NULL, class = NULL) {

  if (!exists("defaults")) defaults <- get_typical_values()
  

## package
  query_params  <- structure(
                     list(url = url,
                          part = part, 
                          fields = fields, 
                          defaults = defaults),
                          class = class)

}

