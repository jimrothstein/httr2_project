#	file <- "400_dropbox_list.R"
# ==============
#		PURPOSE:    DROPBOX
#		
#		USAGE:	
#		STAUTS:		Stuck:  Dropbox has redirect_uri;  must match exactly 
#
#
#		NOTES:
#
#		Looking for NOTES on Httr2 ?
#		SEE tech notes
#
#		TODO:	
#
#		
# ==============

## to get authorize code (step #1)
#https://www.dropbox.com/oauth2/authorize?client_id=<APP_KEY>&response_type=code&code_challenge=<CHALLENGE>&code_challenge_method=<METHOD>
	#
{
library(httr2)
auth_url="https://www.dropbox.com/oauth2/authorize"
token_url="https://api.dropboxapi.com/oauth2/token"
request_url="https://api.dropboxapi.com/2/file_requests/list"

#	Dropbox:  name = "jim_list"
client_id = Sys.getenv("dropbox_client_id")
client_secret = Sys.getenv("dropbox_client_secret")
response_type="code"

scope = "account_info.read files.metadata.read"
redirect_uri =	"http://localhost:8080/callback"

#### Set client
client = oauth_client(id=  client_id,
        token_url  = token_url,
        secret = client_secret,
        key =  NULL,
				auth = "header",
        name = "dropbox")

####	Build req, let httr2:: do it's magic (including server setup) to return resp object.
req = request(request_url)

}

##	Last chance to check

X  <-  httr2::req_oauth_auth_code( req, 
  client = client,
	cache_disk = T,
  auth_url = auth_url,
  scope = scope, 
	port = "8080"			##	to match redirect_uri
	)  
X
resp  <- X %>% req_perform()


##	Dropbox says redirect_uri not same as in setup
##
#=================================================
#		METHOD 2	
##			
##		One of lower_level
##		httr2::oauth_flow_auth_code_url
##
#=================================================
redirect_uri="http://localhost:8080/callback"

##	generates the url where the user is sent.
X  <- httr2::oauth_flow_auth_code_url(
  client = client,
  auth_url = auth_url,
  redirect_uri = redirect_uri,
  scope = scope
  #auth_params = list()
)
X
httr2::request(X) %>% req_perform()
