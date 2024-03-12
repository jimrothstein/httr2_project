
#' ----------------
#' function get_json
#' -----------------
#'
#' @param r response
#' @description Assume response is json, get the content of response, and then extract json.  Finally, convert to an R object.
#' @return json_content
#' @export
#'
get_json <- function(r) {
  text_content <- httr::content(r,"text")
  json_content <- text_content %>% jsonlite::fromJSON()
}
