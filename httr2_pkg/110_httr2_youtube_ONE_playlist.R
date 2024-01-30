#	file <- "110_httr2_youtube_ONE_playlist.R"


# ==============
#		PURPOSE:    ONE Playlist, review videos
#		
#Tue Jun  7 15:09:31 PDT 2022
#		NOT WOKRING
#		
#	
# ==============
library(httr2)

##  URLs,  for base, authorization, token 
# base_url  <- "https://www.googleapis.com/youtube/v3/commentThreads"
{
base_url  <- "https://www.googleapis.com/youtube/v3/playlists"
auth_url = "https://accounts.google.com/o/oauth2/v2/auth"
token_url="https://oauth2.googleapis.com/token"
}
# =============

##  Retrieve from ~/.Renviron
{
API_KEY= Sys.getenv("API_KEY")
client_id = Sys.getenv("OAUTH2_ID")
client_secret = Sys.getenv("OAUTH2_SECRET")
# Google's scope(s) is single string (character[1]) if Multiple separate by whitespace.
scope = paste0("https://www.googleapis.com/auth/youtube.force-ssl ",
							"https://www.googleapis.com/auth/youtube")
scope

auth_params=list(scope=scope, response_type="code") 

			 #### Set client
client = oauth_client(id=  client_id,
        token_url  = token_url,
        secret = client_secret,
        key =  API_KEY,
        #auth = "body",   # header or body
				auth = "header",
        name = "youtube_ONE_video_ALL_comments")

####	Build req, let httr2:: do it's magic (including server setup) to return resp object.
##	GET ALL PLAYLISTS
{

fields=paste(sep=",", "nextPageToken",
                  "items(snippet(title,description,publishedAt))")
req = request("https://www.googleapis.com/youtube/v3/playlists")
req  <- req |> req_url_query(part="snippet", mine="true",  fields=fields)
}

X  <-  httr2::req_oauth_auth_code( req, 
  client = client,
	cache_disk = F,
  auth_url = auth_url,
  scope = scope, 
  pkce = T,
	auth_params = auth_params ,
  token_params = list( scope=scope, grant_type="authorization_code"),
  host_name = "localhost", host_ip = "127.0.0.1",
  port = httpuv::randomPort()
	)  
X
resp  <- X %>% req_perform()


# #### Continue (json, tibble, youtube pagination) for results: (not shown)
# resp_status(resp)
# resp_status_desc(resp)
# sapply(list(resp_status, 
# 						resp_status_desc,
# 						resp_content_type), function(f) f(resp))
# 
# resp_headers(resp)
# 
# #resp_body_raw(resp)
# #resp_body_string(resp)
# #	convert to R object
# r  <- resp_body_json(resp)
# #resp_body_html(resp)
# resp_link_url(resp)
# ####	Extract JSON
# 
# Use jsonLite tools
# library(jsonlite)
# library(data.table)
# r$items
# 
# ####	examine just 1
# row  <- list()
# row[[1]]  <- r$items[[1]]
# id = row[[1]]$id
# name = row[[1]]$snippet$title
# date = row[[1]]$snippet$publishedAt
# desc =row[[1]]$snippet$description
# ####
# ###
# ###
# ###
# Works: (postman)
# https://www.googleapis.com/youtube/v3/playlists?mine=true&part=snippet&fields=nextPageToken,items(snippet(title,publishedAt))
# 
# same, works in G- explorer
# part = snippet&
# mine = true&
# fields = nextPageToken,items(snippet(title,publishedAt))
# 
# # from Google Explorer,  to ask user for permission; then return playlists
# # curl \
# # 'https://youtube.googleapis.com/youtube/v3/playlists? \
# # part=snippet%2CcontentDetails&mine=true&key=[YOUR_API_KEY]' \
# # --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
# # --header 'Accept: application/json' \
# # --compressed
# 
# 
# #	from Google Playground, the request, to get user permission (returns code)
# 
# # HTTP/1.1 302 Found
# # Location: https://accounts.google.com/o/oauth2/v2/auth?
# # redirect_uri=https%3A%2F%2Fdevelopers.google.com%2Foauthplayground&
# #   prompt=consent&
# #   response_type=code&
# #   client_id=407408718192.apps.googleusercontent.com&
# #   scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fyoutube+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fyoutube.force-ssl&
# #   access_type=offline
# 
# # (1)
# #	cut & paste from Google Playground
# X  <- request("https://accounts.google.com/o/oauth2/v2/auth?redirect_uri=https://developers.google.com/oauthplayground&prompt=consent&response_type=code&client_id=407408718192.apps.googleusercontent.com&scope=https://www.googleapis.com/auth/youtube+https://www.googleapis.com/auth/youtube.force-ssl&access_type=offline")
# 
# 
# # (2)
# resp  <- req_perform(X)
# resp  |> resp_content_type()
# resp |> resp_body_html()
# str(resp)
