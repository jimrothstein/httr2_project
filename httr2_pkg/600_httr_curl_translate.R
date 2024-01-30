#file <- "600_httr_curl_translate.R"
# ==============
#		PURPOSE:    Is httr2::curl_translate useful??
#		
#		USAGE:	
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
library(httr2)


curl_translate("curl http://example.com -X DELETE")
# request("http://example.com") %>% 
#   req_method("DELETE") %>% 
#   req_perform()

#	from dropbox
the_url="https://www.dropbox.com/oauth2/authorize?client_id=<APP_KEY>&response_type=code&code_challenge=<CHALLENGE>&code_challenge_method=<METHOD>"

curl_translate(paste0("curl ", the_url))

# request("https://www.dropbox.com/oauth2/authorize?client_id=<APP_KEY>&response_type=code&code_challenge=<CHALLENGE>&code_challenge_method=<METHOD>") %>% 
#   req_perform()


