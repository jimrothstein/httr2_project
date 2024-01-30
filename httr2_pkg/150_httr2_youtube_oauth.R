
#===================================================
##		PURPOSE:    HTTR2::   Obtain bearer token 
##								Using httr2::oauth_flow_auth_code to obtain code, followed by tokens

##	REF : 
##	https://httr2.r-lib.org/articles/httr2.html
#===================================================

##    Collect G- API key, obfuscate, other Useful client_id, Project 2, R_code=Oauth2
{
library(httr2)
key  <- Sys.getenv("OAUTH2_ID")
secret  <- Sys.getenv("OAUTH2_SECRET")
token_url="https://oauth2.googleapis.com/token"
auth_url = "https://accounts.google.com/o/oauth2/v2/auth"
## obfuscate the secret
## httr2::obfuscate(secret)

### Youtube scopes
scope  <- c("https://www.googleapis.com/auth/userinfo.profile", 
          "https://www.googleapis.com/auth/userinfo.email", 
          "https://www.googleapis.com/auth/youtube",  # manage 
          "https://www.googleapis.com/auth/youtube.readonly", 
          "https://www.googleapis.com/auth/youtube.force-ssl")  

##	youtube wants single string, with space between multiple scopes
scope  <- paste0(scope[[3]]," ", scope[[5]])
scope

####    Create client to youtube
client = httr2::oauth_client(
        id =    key,
        secret = secret,
				token_url=token_url,
        name = "jim-youtube_attempt1"            
    )
}


#=================================
#	METHOD one
####		SEEMS TO WORK:
####    Chrome Brower opens; Ask user to authorize (in browser) and get token.
###			Browser returns with following in url windown; SEEMS TO WORK
###			localhost:1720xxxxxx state=<....>   code=>=<....>   scope = <....> 
###

###			Returns "object" with both refresh token and access token; no errors	
###
##
#=================================
{
token  <-   oauth_flow_auth_code(client, 
										 auth_url = auth_url, 
                     scope = scope
                     )
token

# httr2 does its best to redact the Authorization header so that you don't
# accidentally reveal confidential data. Use `redact_headers` to reveal it:
print(req, redact_headers = FALSE)
}





