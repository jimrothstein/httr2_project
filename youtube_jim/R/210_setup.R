# 210_setup.R

## Begin using youtubeR package, from Kevin
library(youtubeR)
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
