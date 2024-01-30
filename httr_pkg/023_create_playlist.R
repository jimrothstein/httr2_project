# 013_create_playlist.R 

# ---- PURPOSE ----
# create new, empty playlist 
# ----------------

# 001_initalize
# ===============
here::here()
load_all()
api  <- get_api_codes()

myapp  <- tuber::yt_oauth(app_id = api$oauth2_id,
													app_secret = api$oauth2_secret)



# ===============================
# 002_setup call to httpbin.org
# ===============================

google_token = base::getOption("google_token")  # oauth info
config  <- set_config(google_token)

query <- list(part="snippet,status") 

body <- '{"snippet":{"title":"Sample playlist created via API","description":"This is a sample playlist description.","tags":["sample playlist","API call"],"defaultLanguage":"en"},"status":{"privacyStatus":"private"}}'

##
httr::POST(url="http://httpbin.org/post", 
					 query = query, 
					 body=body, 
					 encode="json",
					 config=config)
##


# ==========================================
#### 003_youtube_api_create_empty_playlist
# ==========================================

# works!
google_token = base::getOption("google_token")  # oauth info
config  <- set_config(google_token)

base_url <- "https://www.googleapis.com/youtube/v3/playlists"

body <- '{"snippet":{"title":"Sample playlist created via API","description":"This is a sample playlist description.","tags":["sample playlist","API call"],"defaultLanguage":"en"},"status":{"privacyStatus":"private"}}'

query <- list(part="snippet,status") 

# not needed
httr::add_headers(Accept: application/json, ..., .headers = character())

# not needed
httr::add_headers(data =   '{"snippet":{"title":"Sample playlist created via API","description":"This is a sample playlist description.","tags":["sample playlist","API call"],"defaultLanguage":"en"},"status":{"privacyStatus":"private"}}')


r <- httr::POST(url=base_url, 
								query =  query,
								body = body,
								encode="json",
								config = config
								)

httr::content(r)
# ================

## DELETE playlist
# ==================
## https://www.youtube.com/playlist?list=PLbcglKxZP5PMezfs_y6WOXRaR1fK51_ae

# skeleton, must add query =,  as ....
# DELETE(url, config, body, encode="json")

base_url <- "https://www.googleapis.com/youtube/v3/playlists"
id <-  "PLbcglKxZP5PMezfs_y6WOXRaR1fK51_ae"

query <- list(id = id)
# body - not needed

google_token = base::getOption("google_token")  # oauth info
config  <- set_config(google_token)



r <- httr::DELETE(url=base_url,
									query = query, # attached to url string
									config = config,
									encode="json")

# success = NULL
httr::content(r)
