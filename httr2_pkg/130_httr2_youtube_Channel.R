
#	file <- "100_httr2_youtube_ALL_playlists.R"
# ==============
#		PURPOSE:    
#				List channel info (just 1 line of results)
#				GET https://www.googleapis.com/youtube/v3/channels		

#	sample Code
curl \
  'https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2Cstatistics&maxResults=5&mine=true&fields=items(snippet(title%2Cdescription%2CpublishedAt%2CcustomUrl%2Ccountry))%2Citems(statistics(viewCount%2CsubscriberCount%2CvideoCount))&key=[YOUR_API_KEY]' \
  --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
  --header 'Accept: application/json' \
  --compressed

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
base_url="https://www.googleapis.com/youtube/v3/channels"		
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

##	for channel
fields=paste(sep=",", 
"items(snippet(title,description,publishedAt,customUrl,country))",
"items(statistics(viewCount,subscriberCount,videoCount))")

token_params = list( scope=scope, grant_type="authorization_code")

maxResults=5
nextPageToken=-1	
}

fields

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
#					req_url_query(part="snippet", regionCode="US")
					#req_url_query(part="snippet,statistics", mine="true", fields=fields, maxResults=maxResults)
					req_url_query(part="snippet,statistics", mine="true", fields=fields,  maxResults=maxResults)


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


####	channels

{

batch  <- list()
i=0
while(!is.null(nextPageToken)){

	# first time
	if (nextPageToken == -1) {
		resp  <- req |> req_perform()

	} else {
		resp <- req %>% req_url_query(pageToken=nextPageToken) %>% req_perform()
	}
	i=i+1

##	r1 list of two items; one with nextPageToken 	and the other can be converted to dt
	r1  <- httr2::resp_body_json(resp, simplifyVector=T, flatten=T)

	nextPageToken=r1$nextPageToken
  message("Retrieving batch ", i)
  batch[[i]] <- as.data.table(r1$items)	 
}
}



##	print, only need this
{
playlists  <- data.table::rbindlist(batch)
knitr::kable(playlists)

#	to console
playlists[order(snippet.title), .(snippet.title, id)] 
# https://www.youtube.com/playlist?list=PLbcglKxZP5PMNitR0CS2P2fcjD-UFAFTL
prefix <- "https://www.youtube.com/playlist?list="
playlists[, .(snippet.title, id, link=paste0(prefix, id))]
}

##	Dsiplay html in browser
{
	# text to display, url
text_spec("kableExtra", link = "https://haozhu233.github.io/kableExtra/")
playlists[order(snippet.title), 
					.(snippet.title, id, link=kableExtra::text_spec(id, link=paste0(prefix,id)))] %>% 
						kbl(format="html", escape=F)
}



####	FUtURE: fancy printing
###
{
library(kableExtra)
## opens up firefox:
kbl(playlists) %>% kable_styling(full_width = F) %>% column_spec(2, width= "30em")
}
{
	city  <- c("NY", "DC")
	newspaper  <- c("https://www.nytimes.com", "https://www.washingtonpost.com")
	dt  <- data.table(city = city, newspaper=newspaper)
	dt
	dt[, .(city, url_link=paste0("https://", newspaper))]


	# try number 2
	# create url_link, by obtaining `newspaper` for that cell and computing
	# `link` as specified 
	city  <- c("NY", "DC")
	newspaper  <- c("www.nytimes.com", "www.washingtonpost.com")
	dt  <- data.table(city = city, newspaper=newspaper)

	dt
	dt[, .(city, 
				 url_link=kableExtra::text_spec(newspaper, link=paste0("https://", newspaper)))] %>% 
	kbl( format="html", escape=F)


