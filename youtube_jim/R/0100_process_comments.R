#' process one batch of comments from raw response. 
#' @description  takes prior comments tibble, retrieves next batch of comments,
#' rbinds and returns tibble.
#' @param r raw response
#' @param comments tibble contains prior comments
#' @keywords internal

process_comments  <- function(r, comments = tibble::tibble()) {
  json_content <- get_json(r)
  next_comments <- json_content$items$snippet$topLevelComment$snippet
  next_comments  <- tibble::as_tibble(next_comments)
  comments <- rbind(comments, next_comments)
}

#' process one batch of playlists from raw response. 
#' @description  takes prior playlists tibble, retrieves next batch of playlists,
#' rbinds and returns tibble.
#' @param r raw response
#' @param playlists tibble contains prior playlists
#' @keywords internal

process_playlists  <- function(r, playlists = tibble::tibble()) {
  json_content <- get_json(r)

  next_playlists <- cbind(playlistId =json_content$items$id,
                          json_content$items$snippet)
  next_playlists <- tibble::as_tibble(next_playlists)


  playlists <- rbind(playlists, next_playlists)
}


## future S3
if(F) { 
process  <- function(x, ...) UseMethod("process")


process_playlists  <- function(r, playlists = tibble::tibble()) {
  json_content <- get_json(r)
  next_playlists <- cbind(playlistId =json_content$items$id,
                          json_content$items$snippet)
  next_playlists <- tibble::as_tibble(next_playlists)
  playlists <- rbind(playlists, next_playlists)
}
}
