# ==============
# 		PURPOSE:
# Use httr2::, oauth2 to list ALL PLAYLISTS for user
# req_oauth_auth_code                                 
# STATUS:   WORKING, upto 50                                    
# ==============
# GET https://youtube.googleapis.com/youtube/v3/playlists?part=snippet&mine=true&fields=items(snippet(title))&key=[YOUR_API_KEY] HTTP/1.1
 				
  library(httr2)
  library(tibblify)
  request_url <- "https://www.googleapis.com/youtube/v3/playlists"
  auth_url <- "https://accounts.google.com/o/oauth2/v2/auth"
  token_url <- "https://oauth2.googleapis.com/token"
  API_KEY <- Sys.getenv("API_KEY")
  client_id <- Sys.getenv("YOUTUBE_CLIENT_ID")
  client_secret <- Sys.getenv("YOUTUBE_CLIENT_SECRET")
  scope  <-  "https://www.googleapis.com/auth/youtube.readonly"
  maxResults  <-  40

## More preliminaries

  ## 	Construct client
  client <- oauth_client(
    id = client_id,
    token_url = token_url,
    secret = client_secret
)
# Need nextPageToken here
fields <- paste(sep = ",", "nextPageToken,items(snippet(title,description,publishedAt))")
 

  ## 	Build request object, let httr2:: do it's magic (including server setup) to return resp object.

req <- request(request_url) |>
    req_user_agent("package:  wapir, httr2, mailto: jimrothstein@gmail.com") |>
    req_error(is_error = ~FALSE) |> # do not turn errors into R:
    req_url_query(part = "snippet", mine = "true", fields = fields, maxResults=maxResults) |>
    httr2::req_oauth_auth_code(
      client = client,
      auth_url = auth_url,
      cache_disk = T,
      scope = scope,
      pkce = T)

utils::URLdecode(req$url)
names(req)

req$headers
req$policies

resp <- req %>% req_perform()


(ans  <- resp |> httr2::resp_body_json())
names(ans)
resp_status(resp)
resp_headers(resp)
ans$nextPageToken
resp_headers(resp)

## Pagination
# If all the abvoe is working,  then ....


# manually, prepare next_req
# if next_req returns NULL, req_perform_iterations knows to stop
# othewise, req_perform_iterations returns a LIST of responses.

next_req <- function(resp, req) {
  body <- resp_body_json(resp)
  nextPageToken <- body$nextPageToken
  if (is.null(nextPageToken))
    return(NULL)
  req |> req_url_query(pageToken = nextPageToken)
}

resp
req

next_req(resp,req)

# all at once, list
L  <- req |> req_perform_iterative(
    next_req = next_req,
    max_reqs=3,
    progress = T
    )


L
length(L) #  max_reqs x maxResults 

X = lapply(L, resp_body_json)
length(X)
length(X[[1]])
X[[1]]

X[[2]]


# ITERATE
                                        # `

#WITH CURSOR  ... working !
resp_param_value   <- function(resp) {
    content=resp_body_json(resp)
    if (is.null(content$nextPageToken)) return(NULL)
    return(content$nextPageToken)}

next_req = iterate_with_cursor(
   param_name = "pageToken",
   resp_param_value= resp_param_value)


M  <- req |> req_perform_iterative(
                 max_reqs=3,
                 progress=T,
                 next_req =    next_req
   ) 
M   
X = lapply(M, resp_body_json)  
tibblify(X)
