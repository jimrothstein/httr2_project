# ==============
# 		PURPOSE:
# Use httr2::, oauth2 to list ALL PLAYLISTS for user
# STATUS:   WORKING                                    ba
# ==============
# GET https://youtube.googleapis.com/youtube/v3/playlists?part=snippet&mine=true&fields=items(snippet(title))&key=[YOUR_API_KEY] HTTP/1.1
 				
  library(httr2)
  request_url <- "https://www.googleapis.com/youtube/v3/playlists"
  auth_url <- "https://accounts.google.com/o/oauth2/v2/auth"
  token_url <- "https://oauth2.googleapis.com/token"
  API_KEY <- Sys.getenv("API_KEY")
  client_id <- Sys.getenv("YOUTUBE_CLIENT_ID")
  client_secret <- Sys.getenv("YOUTUBE_CLIENT_SECRET")

scope  <-  "https://www.googleapis.com/auth/youtube.readonly"

## More preliminaries

  ## 	Construct client
  client <- oauth_client(
    id = client_id,
    token_url = token_url,
    secret = client_secret,
)

## 	Begin assembly for  httr2::req_oauth_auth_code()
## 		But do not run, yet

  #  auth_params <- list(scope = scope, response_type = "code")
  #auth_params <- list(scope = scope)
  #token_params <- list(scope = scope, grant_type = "authorization_code")


fields <- paste(sep = ",", "nextPageToken", "items(snippet(title,description,publishedAt))")
 

  ## 	Build request object, let httr2:: do it's magic (including server setup) to return resp object.

req <- request(request_url)

  req <- req |>
    req_error(is_error = ~FALSE) |> # do not turn errors into R:
    req_url_query(part = "snippet", mine = "true", fields = fields)



  ## 	X is final request object
    # authenticate first
 X <- httr2::req_oauth_auth_code(req,
    client = client,
    auth_url = auth_url,
    cache_disk = T,
    scope = scope,
    pkce = T,
    #auth_params = auth_params,
#    token_params = token_params
  )


## 	Final check, proceed to perform.   After user authorizes, run the request.
{
  resp <- X %>% req_perform()
}

resp |> httr2::resp_body_json()
## 					E R R O R ....


##i LEGACY
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
