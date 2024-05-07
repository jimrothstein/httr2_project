# ==============
# 		PURPOSE:
# Use httr2::, oauth2 to list ALL PLAYLISTS for user
# req_oauth_auth_code                                 
# STATUS:   WORKING, upto 50                                    
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
  maxResults  <-  500

## More preliminaries

  ## 	Construct client
  client <- oauth_client(
    id = client_id,
    token_url = token_url,
    secret = client_secret,
)
fields <- paste(sep = ",", "nextPageToken", "items(snippet(title,description,publishedAt))")
 

  ## 	Build request object, let httr2:: do it's magic (including server setup) to return resp object.

req <- request(request_url)

  req <- req |>
    req_error(is_error = ~FALSE) |> # do not turn errors into R:
    req_url_query(part = "snippet", mine = "true", fields = fields, maxResults=maxResults)

req

  ## 	X is final request object
req <- httr2::req_oauth_auth_code(req,
    client = client,
    auth_url = auth_url,
    cache_disk = T,
    scope = scope,
    pkce = T)


## 	Final check, proceed to perform.   After user authorizes, run the request.

  resp <- req %>% req_perform()


(ans  <- resp |> httr2::resp_body_json())
resp_status(resp)
resp_headers(resp)
ans$nextPageToken

## Pagination
# If all the abvoe is working,  then ....


next_req <- function(resp, req) {
    browser()
  body <- resp_body_json(resp)
  nextPageToken <- body$nextPageToken
  if (is.null(nextPageToken))
    return(NULL)
  req |> req_body_json_modify(nextPageToken= nextPageToken)
  }
resp
req

next_req(resp,req)

ha
ttr2::iterate_with_cursor(
                      param_name = "nextPageToken",
                      resp_param_value = \(resp) {
                          content  <- resp_body_json(resp)
                          if (is.null(content$nextPageToken)){
                              return(NULL)
                              } else {
                          return(content$nextPageToken)
                          }
                          }
)
req |> httr2::req_perform_iterative(
                  next_req  = next_req,
         max_reqs=10,
         progress=T
)

req |> req_perform_iterative(
    next_req = iterate_with_cursor(
      "cursor",
      resp_param_value = \(resp) {
        content <- resp_body_json(resp)
        if (!length(content$nextPageToken)) return(NULL)
        content$nextPageToken
      }
    ),
    max_reqs = Inf
  )
