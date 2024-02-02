# 	file <- "100_httr2_youtube_ALL_playlists.R"
# ==============
# 		PURPOSE:
# 				Use httr2::, oauth2 to list ALL PLAYLISTS for user
#

# ==============

## 	gather needed params for youtube api, playlists
{
  library(httr2)
  request_url <- "https://www.googleapis.com/youtube/v3/playlists"
  auth_url <- "https://accounts.google.com/o/oauth2/v2/auth"
  token_url <- "https://oauth2.googleapis.com/token"

  ##  Retrieve from ~/.Renviron
  API_KEY <- Sys.getenv("API_KEY")
  client_id <- Sys.getenv("OAUTH2_ID")
  client_secret <- Sys.getenv("OAUTH2_SECRET")

  ##  Google wants multiple scopes separated by white space.
  #  scope <- paste0(
  #    "https://www.googleapis.com/auth/youtube.force-ssl ",
  #    "https://www.googleapis.com/auth/youtube"
  #  )
}

# 2023-12-07 G- complains can only have ONE scope
scope <- paste0("https://www.googleapis.com/auth/youtube.force-ssl")
scope <- "https://www.googleapis.com/auth/youtube"
scope

## 	Begin assembly for  httr2::req_oauth_auth_code()
## 		But do not run, yet
{
  #  auth_params <- list(scope = scope, response_type = "code")
  auth_params <- list(scope = scope)
  fields <- paste(
    sep = ",", "nextPageToken",
    "items(snippet(title,description,publishedAt))"
  )
  token_params <- list(scope = scope, grant_type = "authorization_code")

  ## 	Construct client
  client <- oauth_client(
    id = client_id,
    token_url = token_url,
    secret = client_secret,
    key = API_KEY,
    auth = "body",
    # auth = "header",
    name = "youtube_ALL_PLAYLISTS"
  )


  ## 	Build request object, let httr2:: do it's magic (including server setup) to return resp object.

  req <- request(request_url)
  req <- req |>
    req_error(is_error = ~FALSE) |> # do not turn errors into R:
    req_url_query(part = "snippet", mine = "true", fields = fields)



  ## 	X is final request object
  X <- httr2::req_oauth_auth_code(req,
    client = client,
    auth_url = auth_url,
    cache_disk = T,
    scope = scope,
    pkce = T,
    auth_params = auth_params,
    token_params = token_params
  )
}

## 	Final check, proceed to perform.   After user authorizes, run the request.
{
  resp <- X %>% req_perform()
}

## 					E R R O R ....

## 	Error 400: invalid_request
## 	OAuth 2 parameters can only have a single value: scope

resp

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
