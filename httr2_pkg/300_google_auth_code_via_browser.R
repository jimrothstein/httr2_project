
---
title: "`r knitr::current_input()`"
date: "`r paste('last updated', 
    format(lubridate::now(), ' %d %B %Y'))`"
output:   
  html_document:  
        code_folding: show
        toc: true 
        toc_depth: 4
        toc_float: true
  pdf_document:   
    latex_engine: xelatex  
    toc: true
    toc_depth:  4   
fontsize: 11pt   
geometry: margin=0.4in,top=0.25in   
TAGS:  regression
---

PURPOSE:      To obtain google AUTH CODE via browser.
              - For both Google PEOPLE API   and Google YOUTUBE API.
              - Use R to construct url string to place in browser.

              STOP.  Separately, should be able via curl to get access token and bearer token.
              Do not do this in this file.
 
              

#### As of 20MAR, pasting resulting string into browser WORKS for PeopleAPI.


#'  Google PEOPLE: oauth_code
#'  Paste string below into browser, approve  the popups in browser
#'  Cut and Paste resulting authorization code
#'

#+ assemble_people
client_id  <- Sys.getenv("PEOPLE_CLIENT_ID") 
    b  <- paste0("https://accounts.google.com/o/oauth2/v2/auth?client_id=",
        client_id,  "&",
        "redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/userinfo.profile&response_type=code")
b

#+ save_code
# after save, delete!
writeLines("4<snip>",
"_pepole_auth_code.txt")

readLines("_people_auth_code.txt")


  
#'` Works,   1APR 2022 
#'  Google YOUTUBE:   oauth code
#'  Paste string below into browser, approve  the popups in browser
#'  Cut and Paste resulting authorization code
#'
#+ assemble_string
#
API_KEY  <- 

OAUTH2_ID  <-  Sys.getenv("OAUTH2_ID")
client_id  <- OAUTH2_ID
OAUTH2_ID
OAUTH2_SECRET  <- Sys.getenv("OAUTH2_SECRET")

base_url  <- "https://accounts.google.com/o/oauth2/v2/auth"

#	TODO  replace scope with list + code to unlist
q  <- list(client_id = client_id,
					 redirect_uri="urn:ietf:wg:oauth:2.0:oob",
					 scope = "https://www.googleapis.com/auth/youtube+https://www.googleapis.com/auth/youtube+https://www.googleapis.com/auth/youtube.force-ssl",
					 response_type="code")
q
q= unlist(q)
q
vapply(q, function(x) {paste0(names(x), "=", x, "&")}, character(1), USE.NAMES = T)


					  
b  <- paste0( "https://accounts.google.com/o/oauth2/v2/auth?client_id=",
             client_id, "&", 
             "redirect_uri=urn:ietf:wg:oauth:2.0:oob&",
"scope=https://www.googleapis.com/auth/youtube+https://www.googleapis.com/auth/youtube+https://www.googleapis.com/auth/youtube.force-ssl&response_type=code"
)
b
# paste into browser


#+ save_code
# after save, delete!
writeLines("4/1Asnip",
"_auth_code.txt")

readLines("_auth_code.txt")


#'  Using google api key only,
#'  build a cURL expression for youtube
#'  use httr2::curl_translate
```

#+ change_uri
b  <- paste0( "https://accounts.google.com/o/oauth2/v2/auth?client_id=",
             client_id, "&", 
             "redirect_uri=127.0.0.1:8080&",
"scope=https://www.googleapis.com/auth/youtube+https://www.googleapis.com/auth/youtube+https://www.googleapis.com/auth/youtube.force-ssl&response_type=code"
)
b
# paste into browser 
# 1APR2022 google returns 400, invalid_request ... don't think this method is
# method for browser
```{r}

url="https://youtube.googleapis.com/youtube/v3/search"
query='?part=snippet&maxResults=5&q=Lennon%20Sisters'
query

##  Construct URL
#   use key=   (for Google)
#   use $key  for oauth2
#   use $api_key for api

API_KEY= Sys.getenv("API_KEY")
url  <- paste0(url, "?key=", API_KEY)
url  <- paste0(url, "&", query)
url


echo "Running it ..."
# 
curl -v $URL \
  --header 'Accept: application/json' \
  --compressed

exit

```




