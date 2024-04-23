# 010_httr2_example_url.R

# PURPOSE:	test httr2::example_url()
# 		starts webserver on localhost
		
		runs an app webfakes::httpbin_app()

# ----------
		## setup
# ----------
library(httr2)
library(rlang)
library(webfakes)

rlang::check_installed("dplyr")
## offers to install 'dope'
if (F) {
        rlang::check_installed("dope")
}

# --------------------
#	start webserver on localhost, using webakes::httpbin_app()
httr2::example_url()
# --------------------

# mimics retriving data set (iris) via httr2:: requests
# dim(iris) 150 x 5

# --------------------------------------------------------
##	example:  retrieve iris data by req_perform_iterative
##	iterative, by page
# --------------------------------------------------------
req <- request(example_url()) |>
  req_url_path("/iris") |>
  req_throttle(10) |>                  # 10 requests per second 
  req_url_query(limit = 5)

##	
## GET http://127.0.0.1:33705/iris?limit=5&page_index=20
## 
##	default max_reqs=20; increase to see progression
resps <- req_perform_iterative(req, max_reqs= 100, iterate_with_offset("page_index"))
resps
length(resps)

