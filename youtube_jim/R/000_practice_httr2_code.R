# 000_practice_httr2_code.R

##  PURPOSE:  Start local web server and an R app to communicate
library(httr2)
library(webfakes)

##
httr2::example_url() # starts server
httr2::example_github_client()


##  WEBFAKES
webfakes::httpbin_app()
httpbin <- webfakes::new_app_process(webfakes::httpbin_app())

##  START local server
browseURL(httpbin$url())

?webfakes
