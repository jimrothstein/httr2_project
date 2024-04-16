

#	file <- "02_chapter.R"
library(httr2)
library(crul)
github_url <- "https://kctbh9vrtdwd.statuspage.io/api/v2/status.json"

library("magrittr")

##	httpbin to study
{
resp  <- httr2::request("http://httpbin.org/headers") %>% httr2::req_perform()
httr2::resp_body_json(resp)
httr2::resp_headers(resp)

# get req ip
resp  <- httr2::request("http://httpbin.org/ip") %>% httr2::req_perform()
httr2::resp_body_json(resp)


# get req usr-agent
resp  <- httr2::request("http://httpbin.org/user-agent") %>% httr2::req_perform()
httr2::resp_body_json(resp)

resp  <- httr2::request("http://httpbin.org/anything?x=1") %>% httr2::req_perform()
httr2::resp_body_json(resp)
}


response <- httr2::request(github_url) %>%
  httr2::req_perform()

	{
response
httr2::resp_status(response)

# Or in a package you'd write
httr2::resp_check_status(response)

# Parse the content
p  <- httr2::resp_body_json(response)
str(p)

httr2::resp_header(response, "content-type")
# [1] "application/json; charset=utf-8"
	}


#### Crul:: package (no Oauth)
	{
# Create a client and get a response
client <- crul::HttpClient$new(github_url)
client
response <- client$get()
response

# Check the response status
response$status_http()

# Or in a package you'd write
response$raise_for_status()

# Parse the content
response$parse()

## No encoding supplied: defaulting to UTF-8.

## [1] "{\"page\":{\"id\":\"kctbh9vrtdwd\",\"name\":\"GitHub\",\"url\":\"https://www.githubstatus.com\",\"time_zone\":\"Etc/UTC\",\"updated_at\":\"2022-06-06T01:38:19.486Z\"},\"status\":{\"indicator\":\"none\",\"description\":\"All Systems Operational\"}}"

#	convert to R list format
jsonlite::fromJSON(response$parse())
