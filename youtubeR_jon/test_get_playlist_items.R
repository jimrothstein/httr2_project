#   TAGS:   

##  Sample constants
## other ways to put into global env?
start  <- function(){
  channelId <<-  "UClB5qWyXejlAwwkDAzJis-Q" # my channel  
  videoId <<- "QgdVd7ujEro" # Brenda Lee
  playlist_id <<- "PLbcglKxZP5PMU2rNPBpYIzLTgzd5aOHw2"
}
start()
if (F) {
  devtools::install_github("kevin-m-kent/youtubeR")
}

##  Did you document(), install() latest version of youtubeR?
library(youtubeR)

?get_my_playlists()

## will need to authenticate
z  <-  get_my_playlists()

###
# ---
videos  <- youtubeR::get_playlist_items(playlist_id = playlist_id)
videos

L= list(a=1, b=2)
L[["b"]]

## Example, this has no videoPublishedAt
videos[[5]]


## worksings
tibble(videoId = unlist(map(videos, pluck, c("videoId" ))), 
       videoPublishedAt = unlist(map( videos, pluck, c("videoPublishedAt" ),
                                     .default = NA))
       )



?make_tibble
make_tibble(playlistId=playlist_id)
vim:linebreak:nospell:nowrap:cul tw=78 fo=tqlnrc foldcolumn=1 cc=+1
