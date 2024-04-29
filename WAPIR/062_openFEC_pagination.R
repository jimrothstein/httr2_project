From Jon's slides

# PURPOSE:   openFEC, with iterate to return all api info for request

library(httr2)

# -------------
#basic request
# -------------

candidates_request <- 
  request("https://api.open.fec.gov/v1/candidates") |> 
  req_url_query(api_key = "DEMO_KEY", election_year = 2020, office = "P") |> 
  req_url_query(has_raised_funds = TRUE)
candidates_request

# run
candidates_single <- 
  candidates_request |> 
  req_perform() |> 
  resp_body_json()

# -------
# probe
# -------
names(candidates_single) 

# 20 per page x 9 pages 
candidates_single$pagination

length(candidates_single$results) #> [1] 20
candidates_single$pagination$count #> [1] 173


# ------------------------------------
#| : httr2-pagination-fec-multi
# each request, returns one page?

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
length(candidates_multi)

resp_body_json(candidates_multi[[2]])
