
###	OLD first setup (from httr)
###
SETUP ! (begin here)
* For Troubleshooting
*  HEAD shows what is being sent (see the simple error?)
*  httr::HEAD("https://www.googleapis.com/youtube/v3/playlists",
 							query= query,
 							config = config) 

REF : 
https://www.r-bloggers.com/2019/01/how-to-authenticate-using-oauth2-through-r-2/
```{r setup, include=FALSE		}
knitr::opts_chunk$set(echo = TRUE,
                      comment = "      ##",
                      error = TRUE,
                      collapse = TRUE)
load_all()
```

#### Remove old .httr-oauth, set options
```{r endpoints}

remove_old_oauth  <- function(){
# remove old .httr-oauth (till I know what I am doing)
  file.remove(".httr-oauth")
}

set_options  <- function() {
  base::options("httr_oauth_cache" = TRUE) 
  # https://developers.google.com/accounts/docs/OAuth2InstalledApp
  httr::oauth_endpoints("google")
}
```

#### Create & Register myapp with Google
```{r register}
#  Security:  key & secret are in ~/.Renviron ( do not push to github )
#  NOTE:  google calls this key as "Client ID"
#   Rmk:   key is visible in myapp

set_app  <- function() {
  myapp <- httr::oauth_app("google",
    key  <- Sys.getenv("OAUTH2_ID"),
    secret  <- Sys.getenv("OAUTH2_SECRET")
    )


myapp
}
myapp  <- set_app()
```

## SCOPES, auth.code
  - Create .httr-oauth (binary) in project root.

##  SCOPE 3 (BEST)
  - USE THIS auth.code for most work
  - Add scope for various youtube access.
  - youtube.force-ssl needed to retrieve user's playists, videos in each
```{r youtube_scopes}
#  

set_scope  <- function(){
scope = 
  c("https://www.googleapis.com/auth/userinfo.profile",
  "https://www.googleapis.com/auth/userinfo.email",
  "https://www.googleapis.com/auth/youtube",  # manage
  "https://www.googleapis.com/auth/youtube.readonly",
  "https://www.googleapis.com/auth/youtube.force-ssl"
        )
}
scope  <- set_scope()

 ```  
## Get auth.code | token ....
```{r get_auth.code}
# NO .httr-oauth?  |  THEN pop, asks users,  AND warns not verified, not safe

# Rmk1:  option("httr_oauth_cache") was set to TRUE , token will then know to store
  auth.code <- httr::oauth2.0_token(
              endpoint = httr::oauth_endpoints("google"),
              app = myapp,
              #cache = getOption("httr_oauth_cache"),
              cache = T,
              scope = scope
)

auth.code

```







#### WORKS
```{r use_api}
req <- httr::GET(
  "https://www.googleapis.com/oauth2/v1/userinfo",
  httr::config(token = auth.code) )

httr::stop_for_status(req)
str(httr::content(req))

### Compare to
httr::headers(req)
```

### identical to GET, but without the body
httr::HEAD("http://google.com")

### headers in response
httr::headers(httr::HEAD("http://google.com"))
```


## Examples
```{r one_video}

# prep for GET
#
get_api_codes  <- function() {
  api  <- list(api_key = Sys.getenv("API_KEY"),
               oauth2_id = Sys.getenv("OAUTH2_ID"),
               oauth2_secret = Sys.getenv("OAUTH2_SECRET"))
}
if (!exists("api")) api <- get_api_codes()

    key  <- Sys.getenv("OAUTH2_ID")

get_typical_values  <- function(){
	values  <- list(
						maxResults = 50,
						channelId =  "UClB5qWyXejlAwwkDAzJis-Q", # my channel
						videoId = "bMaCoxOGXPM",   # You Made me Love You)
						playlistId = "PLbcglKxZP5PMU2rNPBpYIzLTgzd5aOHw2")
}

l <- get_typical_values()
maxResults  <- l$maxResults
playlistId  <- l$playlistId
video_id = l$videoId
base_url <- "https://www.googleapis.com/youtube/v3/videos"


api_opts <- list(part = "snippet",
                 id = video_id,
                 maxResults = maxResults,
                 fields="items(snippet(title))",
                 key = api$api_key)


## TODO:  here r is https://   EXPLAIN
r  <- httr::HEAD(base_url, query = api_opts, httr::config(token= auth.code))


# WORKS!!!!
base_url
api_opts

r  <- httr::GET(base_url, query = api_opts, httr::config(token= auth.code)) 
httr::stop_for_status(r)
httr::content(r)
str(httr::content(r))
```

TODO - not working, missing , in list()  -- is it TRUE, TRUE?
Given a channelId, returns total number of playlists
```{r playlist_count}
api <- get_api_codes()
api

base_url <- "https://www.googleapis.com/youtube/v3/playlists"

# mine =  ????
query  <- list(
						part="snippet, contentDetails",
    				channel_id="UClB5qWyXejlAwwkDAzJis-Q",
            mine = TRUE, 
						maxResults=3,
						fields="pageInfo(totalResults)",
						key = api$api_key
						)

r  <- httr::GET("https://www.googleapis.com/youtube/v3/playlists",
 							query= query,
 							config = httr::config(token = auth.code)
							) %>% httr::stop_for_status()

json_content  <- get_json(r)
count  <- json_content$pageInfo$totalResults
count
#jr_get_total_playlists(query) #142


# see HEAD?
httr::HEAD("https://www.googleapis.com/youtube/v3/playlists",
 							query= query,
 							config = config(token=auth.code))
```


Comments
```{r comments}

api  <- get_api_codes()
base_url <- "https://www.googleapis.com/youtube/v3/commentThreads"
l <- get_typical_values()

#playlistId  <- "PLbcglKxZP5PMZ7afIT7E2o9NwQIzqTI5l"

# fields , careful if split on mutliple lines, use paste
query  <- list(
	part="snippet,replies", 
	maxResults =l$maxResults, 
	fields=paste(sep=", ", "nextPageToken", 
			 "items(snippet(topLevelComment(snippet(videoId,textDisplay))))"
			 ),
	key = api$api_key, 
	pageToken = NULL, 
	videoId = l$videoId)

# google_token = base::getOption("google_token") 
# config  <- httr::config(google_token)

```

## 1st batch
```{r get}

r  <- httr::GET(base_url, query = query, httr::config(token= auth.code))
stop_for_status(r)
httr::content(r)
str(httr::content(r))


#comments  <- process_comments(r, comments)
comments  <- jr_get_batch_comments(base_url, query, config) 
comments
```

***

```{r knit_exit()} 
knitr::knit_exit()
```

\newpage

```{r render, eval=FALSE	} 
file <- ""
file  <- basename(file)
dir <- "rmd"

jimTools::ren_pdf(file,dir)
jimTools::ren_github(file, dir)
```
