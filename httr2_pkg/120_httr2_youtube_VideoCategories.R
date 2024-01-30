
#	file <- "100_httr2_youtube_ALL_playlists.R"
# ==============
#		PURPOSE:    
#				List all videoCategories for region:  US
#				GET https://www.googleapis.com/youtube/v3/videoCategories		

		NOTES:
				region="US"  required
				scope - only need readonly; but wider is OK.
				maxResults - no used.
				nextPageToken - not used.
				loop page-by-page - not needed.
				fields - NONE needed, but can be specific


##	TODO
##		-	token - check if valid
# ==============

##	gather needed params for youtube api, playlists
{
library(httr2)
library(jsonlite)
library(data.table)

#	base_url  <- "https://www.googleapis.com/youtube/v3/playlists"
base_url="https://www.googleapis.com/youtube/v3/videoCategories"		
auth_url = "https://accounts.google.com/o/oauth2/v2/auth"
token_url="https://oauth2.googleapis.com/token"

##  Retrieve from ~/.Renviron
API_KEY= Sys.getenv("API_KEY")
client_id = Sys.getenv("OAUTH2_ID")
client_secret = Sys.getenv("OAUTH2_SECRET")

##  Google wants muliple scopes separated by white space.
##	Not need for videoCategories, any harm?
scope = paste0("https://www.googleapis.com/auth/youtube.force-ssl ",
							"https://www.googleapis.com/auth/youtube")
}

##	Construct client 
{
client = oauth_client(id=  client_id,
        token_url  = token_url,
        secret = client_secret,
        key =  API_KEY,
				auth = "body",
				#auth = "header",
        name = "youtube_ALL_PLAYLISTS")
}

##	Assemble for  httr2::req_oauth_auth_code()
##
{
auth_params=list(scope=scope, response_type="code") 
#fields=paste(sep=",", "nextPageToken", "items(snippet(title,description,publishedAt))")

# not needed:w
fields=paste(sep=",", "items(snippet(title, assignable, channelId))")

token_params = list( scope=scope, grant_type="authorization_code")

# not needed
maxResults=10
nextPageToken=-1	
}



#================================================================
#### SPLIT begins here
#================================================================
####	Workaround, to get token: user must appove in browser
####  Browser - opens
{
token  <-   oauth_flow_auth_code(client, 
										 auth_url = auth_url, 
                     scope = scope
                     )
#unlist(token)
#token[[2]]
#
##	save the token
saveRDS(token, file="token.rds")

##	read the token
token = readRDS(file="token.rds")
}



#### With token, proceed retrieve PLAYLISTS
{
req  <-  request(base_url) %>% 
					req_error(is_error = ~ FALSE) %>%
#					req_url_query(part="snippet", mine="true",  fields=fields, maxResults=maxResults )
					req_url_query(part="snippet", regionCode="US")

req  <- 	req %>% 
						req_auth_bearer_token(token[[2]])   ## 2 is ascii part

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

			  


####	videoCategories greatly simplifies
{
	playlists  <- as.data.table(httr2::resp_body_json(resp, simplifyVector=T, flatten=T))

if (F)	{
batch  <- list()
i=0
while(!is.null(nextPageToken)){

	# first time
	if (nextPageToken == -1) {
		resp  <- req |> req_perform()

	}
	resp

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

} # end if

}


##	print, only need this
{
playlists  <- data.table::rbindlist(batch)
knitr::kable(playlists)
playlists[order(id), .(id,kind, snippet.title, snippet.assignable, snippet.channelId, etag)]
playlists[order(id), .(id, snippet.title, snippet.assignable,  etag)] %>% knitr::kable() 

#playlists[order(snippet.title) , .(snippet.title, snippet.publishedAt)] %>% knitr::kable()
`


####	FUtURE: fancy printing
{
library(kableExtra)
## opens up firefox:
kbl(playlists) %>% kable_styling(full_width = F) %>% column_spec(2, width= "30em")
}

