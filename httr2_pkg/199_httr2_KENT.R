library(httr2)
library(jsonlite)
library(tidyverse)

# set up dev api access on google, choosing desktop for youtube data api
API_KEY <- Sys.getenv("API_Key")
client_id <- Sys.getenv("client_id")
client_secret <- Sys.getenv("client_secret")

token_url <- "https://oauth2.googleapis.com/token"
auth_url <- "https://accounts.google.com/o/oauth2/v2/auth"
scope = "https://www.googleapis.com/auth/youtube"

client <- oauth_client(id=  client_id,
                      token_url  = token_url,
                      secret = client_secret,
                      key =  API_KEY,
                      auth = "body",   # header or body
                      name = "video_upload_api")

# api guide https://developers.google.com/youtube/v3/docs/videos/insert#go
# additional parts need to be specified as arguments in the request string

channel_id_req <- request("https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&mine=true")

resp_channel_id <- httr2::req_oauth_auth_code( channel_id_req,
                                    client = client,
                                    auth_url = auth_url,
                                    scope = scope, 
                                    pkce = FALSE,
                                    auth_params = list(scope=scope, response_type="code"),
                                    token_params = list(scope=scope, grant_type="authorization_code"),
                                    host_name = "localhost",
                                    host_ip = "127.0.0.1",
                                    #port = httpuv::randomPort()
                                    port = 8080, 
) %>%
  # # req_body_multipart(
  #    list(
  #      metadata = curl::form_file(path = metadata, type = "application/json; charset=UTF-8"),
  #      media = curl::form_file("kkent intro.mp4"))
  #  ) %>%
  req_perform() %>%
  resp_body_json()

req <- request("https://www.googleapis.com/youtube/v3/channels?part=contentDetails&mine=true")

snippet_string <- list(snippet = list("title" = unbox("kevin video final"),
                       "description" = unbox("description_test"),
                       "tags" = "kevin,kent"),
status = list("privacyStatus" = unbox("private"))) %>%
  jsonlite::toJSON()

metadata <- tempfile()
writeLines(snippet_string, metadata)

resp <- httr2::req_oauth_auth_code( req,
                                    client = client,
                                    auth_url = auth_url,
                                    scope = scope, 
                                    pkce = FALSE,
                                    auth_params = list(scope=scope, response_type="code"),
                                    token_params = list(scope=scope, grant_type="authorization_code"),
                                    host_name = "localhost",
                                    host_ip = "127.0.0.1",
                                    #port = httpuv::randomPort()
                                    port = 8080, 
) %>%
 # # req_body_multipart(
 #    list(
 #      metadata = curl::form_file(path = metadata, type = "application/json; charset=UTF-8"),
 #      media = curl::form_file("kkent intro.mp4"))
 #  ) %>%
  req_perform()
