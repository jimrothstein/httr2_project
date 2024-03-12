#' helper functions to add video to playlist
#'
#'
#' helper function: set_body 
#' prepare data portion of query to yt
#'
#' @section  Section 1.
#' 
#' @section  Section 2.
#' 
#' @seealso 
#'
#' @param video_id  The youtube assigned id.
#'	@param playlist_id	The youtube assigned playlist id.
#' @return The body portion (header) of the call to the API.
#' @export 
set_body  <- function(video_id, playlist_id){
	# 
	glue::glue(.open= "<"  ,
						 .close= ">" ,
						 '{"snippet":{"playlistId":"<playlist_id>","position":0,"resourceId":{"kind":"youtube#video","videoId":"<video_id>"}}}'
	) 
}


#' add_video Add video to specific playlist_id
#' 
#' 

#' @param url Google specific url for this type of api call.
#' @return
#' @export

add_video  <- function(url, query, body, config) {
r <- httr::POST(url=base_url, 
								query =  query,
								body = body,
								encode="json",
								config = config
								)
}
