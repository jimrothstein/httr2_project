# From Jon's slides

# PURPOSE:   openFEC, ONE candidate 

library(httr2)
library(constructive)
x <- 3
# -------------
#basic request
# -------------

## Ohio, Senate, 2024 R=Moreno
candidates_request <-
  request("https://api.open.fec.gov/v1/candidates") |> 
  req_url_query(api_key = "DEMO_KEY", election_year = 2024, office = "S", state="OH") 
candidates_request
#  req_url_query(has_raised_funds = TRUE)

if (FALSE) {
candidates_request <- 
  request("https://api.open.fec.gov/v1/candidates") |> 
  req_url_query(api_key = "DEMO_KEY", election_year = 2020, office = "P") |> 
  req_url_query(has_raised_funds = TRUE)
candidates_request
}

# run simple request
candidates_single <- 
  candidates_request |> 
  req_perform() |> 
  resp_body_json()

# -------
# probe response
# -------
construct(candidates_single) |> head(n=1)
names(candidates_single) 

# 20 per page x 9 pages 
candidates_single$pagination

length(candidates_single$results) #> [1] 20
candidates_single$pagination$count #> [1] 173


# ------------------------------------
# httr2-pagination-fec-multi
# each request, returns one page

# ------------------------------------
candidates_multi <- 
  candidates_request |> 
  req_retry(max_tries = 3) |> 
  req_perform_iterative(
    next_req = iterate_with_offset(
      "page",
      resp_pages = \(resp) {
        content <- resp_body_json(resp)
        content$pagination$pages
      }
    ),
    #max_reqs = 2  # limits to 2 pages
    max_reqs=Inf
  )

length(candidates_multi)
#> [1] 9
# ---------------
## SAVE to file
# ---------------
candidates_multi <- 
  candidates_request |> 
  req_retry(max_tries = 3) |> 
  req_perform_iterative(
    next_req = iterate_with_offset(
      "page",
      resp_pages = \(resp) {
        content <- resp_body_json(resp)
        content$pagination$pages
      }
    ),
    max_reqs = Inf
  )
saveRDS(
  candidates_multi, 
  "candidates_multi.rds")

# READ
z=readRDS("candidates_multi.rds")

# ----------------------------------
#  run again, 
## replace call back with function
# ----------------------------------

.rp = function(resp){
  content = resp_body_json(resp)
  content$pagination$pages
}

candidates_multi <- 
  candidates_request |> 
  req_retry(max_tries = 3) |> 
  req_perform_iterative(
    next_req = iterate_with_offset(
      "page",
     resp_pages  = .rp    # replace with simple call back function, .rp
    ),
    max_reqs = Inf
  )
#
#  probe response
#

construct(candidates_multi) |> head(1) # error
length(candidates_multi) #9
head(candidates_multi)
resp =  candidates_multi
is.list(resp)
construct(resp[[1]]) # error




resp_body_json(resp) # error
resp_body_json(resp[[1]])
resp_body_json(candidates_multi[[2]]))

candidates_multi
res = resp_body_json(canddidates_multi$results)
