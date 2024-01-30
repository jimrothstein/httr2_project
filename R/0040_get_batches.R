#' get_batch_comments Given videoId, returns one batch comments 

#' @param base_url url for Google api
#' @param query list built prior
#' @param config embed token
#' @export
# get_batch_comments  <- function(base_url, query, config) {
  #   r <- httr::GET(base_url, 
  #                 query = query,
  #                 config = config
  #                 ) %>% httr::stop_for_status()
  # 
  #   json_content <- get_json(r)

	# to get comments, wade through empty levels
#   comments <- json_content$items$snippet$topLevelComment$snippet
#   comments  <- tibble::as_tibble(comments)
# }

#' ---------
#' get_batch_videos
#' ---------
#'
#' @param base_url ur_provide_by_api
#' @param query  query_string
#' @param config  info related to "google_token"
#' @return
#' @export

# get_batch_videos  <- function(base_url,query,config) {
# get a block (upto maxResults)
#       r <- httr::GET(url = base_url, 
#                       query= query, 
#                       config = config
#       ) %>% httr::stop_for_status()
# }
