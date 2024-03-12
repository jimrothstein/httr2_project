
#'-----------------
#' get_typical_values
#'-----------------

#' returns pre-set examples for channelId, playlistId, videoId
#'   and maxResults = 50
#' playlistId <- "PLbcglKxZP5PMBoG1VfCqlWZ1Nx4FBBOn6"  # 60s - female (300+)
#' videoId <- "UCVdHFHpFBg"   # Tex Ritter Range Party
#' @return list
#' @export
get_typical_values  <- function(){
	values  <- list(
						maxResults = 50,
						channelId =  "UClB5qWyXejlAwwkDAzJis-Q", # my channel
						videoId = "bMaCoxOGXPM",   # You Made me Love You)
						playlistId = "PLbcglKxZP5PMU2rNPBpYIzLTgzd5aOHw2")
}

