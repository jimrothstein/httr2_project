# 220_get_playlists.R 
# GOAL: Construct what his yt_call_api  NEEDS

library(youtubeR)


endpoint = "https://www.googleapis.com/youtube/v3/playslists"
query = 
body = 

base_url = 



    #REFERNCE ONLY

if (F) {
browse_gc_credentials()



#
## API_KEY
## OAUTH2_ID
## OAUTH2_SECRET
#

# I used different names in .Renviron
YOUTUBE_CLIENT_ID <- Sys.getenv("OAUTH2_ID")
YOUTUBE_CLIENT_SECRET <- Sys.getenv("OAUTH2_SECRET")

Sys.setenv(YOUTUBE_CLIENT_ID = Sys.getenv("OAUTH2_ID"))
Sys.setenv(YOUTUBE_CLIENT_SECRET = Sys.getenv("OAUTH2_SECRET"))


my_playlist_id <- get_upload_playlist_id()
my_playlist_id
# Ideally, set these in your .Renviron file.
video_ids <- get_playlist_video_ids(my_playlist_id)
video_ids

video_details <- get_video_processing_details(video_ids)
video_details

# --------------------------------------------------------
# one of my playlists
channelId =  "UClB5qWyXejlAwwkDAzJis-Q", # my channel  
videoId <- "QgdVd7ujEro" # Brenda Lee
playlist_id <- "PLbcglKxZP5PMU2rNPBpYIzLTgzd5aOHw2"
get_playlist_items(playlist_id = playlist_id)
}
