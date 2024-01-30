#!/bin/zsh
#   file <- "001_b.sh"

#-----------------------------------------------
# NOTE:
# NO API KEYS are here.   Stored in ~/.Renviron
#-----------------------------------------------
#

# ======================================================
# curl + Google People API 
#
# REF:  https://www.daimto.com/how-to-get-a-google-access-token-with-curl/
# How to get a Google access token with CURL. | Daimto
# ======================================================
#
#   Credentials, aka Client ID (for oauth)
#
#
#NEXT,  use authorization code and get access code

## see ~/.Renviron for snip
curl -sv \
--request POST \
--data {SNIP}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code" \ 
"https://oauth2.googleapis.com/token"

# old url?
#https://accounts.google.com/o/oauth2/token 

exit



# =================================================================
#   -d, --data what to send to server (as if browser had sent it)
# =================================================================
#   PURPOSE:  seek 
curl  -i "http://brentertainment.com/oauth2/lockdin/token" \
    -d "grant_type=password&client_id=demoapp&client_secret=demopass&\
    username=demouser&password=testpass"




# =======================================================================================================================
#   PURPOSE:  seek 
#   REF:  https://stackoverflow.com/questions/53357741/how-to-perform-oauth-2-0-using-the-curl-cli#53357742et CLIENT_ID=Replace_with_your_Client_ID
# =======================================================================================================================
#
#    RMK:
#       In zsh shell var,  H=Hello ,  then $H to use.
#
CLIENT_SECRET=Replace_with_your_Client_Secret
set SCOPE=https://www.googleapis.com/auth/cloud-platform
set ENDPOINT=https://accounts.google.com/o/oauth2/v2/auth

set URL="%ENDPOINT%?client_id=%CLIENT_ID%&response_type=code&scope=%SCOPE%&access_type=offline&redirect_uri=urn:ietf:wg:oauth:2.0:oob"

@REM start iexplore %URL%
@REM start microsoft-edge:%URL%
start chrome %URL%

set /p AUTH_CODE="Enter Code displayed in browser: "

curl ^
--data client_id=%CLIENT_ID% ^
--data client_secret=%CLIENT_SECRET% ^
--data code=%AUTH_CODE% ^
--data redirect_uri=urn:ietf:wg:oauth:2.0:oob ^
--data grant_type=authorization_code ^
https://www.googleapis.com/oauth2/v4/token


