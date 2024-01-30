#		file <- "115_httr2_youtube_ALL_comments_ONE_video.R"

# ==============
#		PURPOSE:    
#		ONE VIEO, all comments
#		NOT WORKING
#Tue Jun  7 15:09:31 PDT 2022
#		
#	
# ==============

##  URLs,  for base, authorization, token 
{
library(httr2)
library(data.table)
base_url  <- "https://www.googleapis.com/youtube/v3/commentThreads"
auth_url = "https://accounts.google.com/o/oauth2/v2/auth"
token_url="https://oauth2.googleapis.com/token"
#video_id=https://www.youtube.com/watch?v=htNrvSiQRls
#videoId
videoId="htNrvSiQRls"  # Swing Dance, 256 comments
fields="items(snippet(topLevelComment(snippet(videoId, textDisplay,authorDisplayName))))"
maxResults=50
}


##  Retrieve from ~/.Renviron
{
API_KEY= Sys.getenv("API_KEY")
client_id = Sys.getenv("OAUTH2_ID")
client_secret = Sys.getenv("OAUTH2_SECRET")
# Google's scope(s) is single string (character[1]) if Multiple separate by whitespace.
scope = paste0("https://www.googleapis.com/auth/youtube.force-ssl")
							#"https://www.googleapis.com/auth/youtube")
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
}


##	browser opens (skip if have token)
{
token  <-   oauth_flow_auth_code(client, 
										 auth_url = auth_url, 
                     scope = scope
                     )
#unlist(token)
#token[[2]]
}

####	Build req, 
###  COMMENTS
{

req = request(base_url)

req  <- req |> req_url_query(part="snippet,replies", videoId=videoId,  fields=fields, maxResults=maxResults)

req  <- 	req %>% 
						req_auth_bearer_token(token[[2]])   ## 2 is ascii part
}


##	Error in original code, so use workaround
{
if (F) {
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
}
}



##	===========
##				RESPONSE
##	===========

#
#
# ####	API returns JSON, use jsonLite to extract info we need
# 

##	by default, httr2::resp_body_json uses simplifyVector = F
##	however,  jsonlite::fromJSON uses   simpllifyVector = T
#	returns atomic or list (NOT JSON object)



	# modify req

##	r1 list of two items; one with nextPageToken 	and the other can be converted to dt

{			  

nextPageToken=-1
batch  <- list()
i=0
while(!is.null(nextPageToken)){

	# first time
	if (nextPageToken == -1) {
		resp  <- req |> req_perform()

	}
# second and thereafter 
#
	else {
		resp <- req %>% req_url_query(pageToken=nextPageToken) %>% req_perform()
	}

	i=i+1

##	r1 list of two items; one with nextPageToken 	and the other can be converted to dt
	r1  <- httr2::resp_body_json(resp, simplifyVector=T, flatten=T)

	nextPageToken=r1$nextPageToken
  message("Retrieving batch ", i)
  batch[[i]] <- as.data.table(r1$items)	 
	}

dt  <- data.table::rbindlist(batch)
}
	
head(dt)
View(dt)
dt[c(1,2)]
str(dt)


