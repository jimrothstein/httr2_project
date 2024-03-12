#'-----------------
#' set_query 
#'-----------------
#' @title set_query 
#' @description sets up query to google api 
#' @details 
#' @return list
#' @export
set_query  <- function(part = NULL, fields = NULL, pageToken = NULL, l = NULL, api=NULL, ...){
 query  <- list(
              part=part,
              maxResults=l$maxResults,  
              # choice ONE:
              videoId = l$videoId,
              playlistId= l$playlistId,	
              fields = fields,
              key=api$api_key
    )  
}
