# 
# REF: HADLEY has demos: oauth1 and oauth 2, various popular apis
# https://github.com/r-lib/httr/tree/master/demo




#'
#' get_oauth_endpoints
#'
#' returns google endpoints
#' @return list
#' @export
#'
get_oauth_endpoints   <- function(x="google") {
	httr::oauth_endpoints(x)
}

