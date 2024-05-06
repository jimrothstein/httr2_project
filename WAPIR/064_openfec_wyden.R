# From Jon's slides

# PURPOSE:   openFEC, ONE candidate  OHIO, Republican

library(httr2)
library(constructive)
x <- 3
                                        #
candidate_id  <- "S6OR00110"  # Wyden
candidate_id <-  "S4OH00226" # Bernie Moreno, R, Ohio
api_key  <- Sys.getenv("API")   # fec api

candidates_request <-
  request("https://api.open.fec.gov/v1/candidates") |> 
  req_url_query(api_key=api_key, election_year=2024, office="S", candidate_id = candidate_id)
candidates_request


# run simple request
candidates_single <- 
  candidates_request |> 
  req_perform() |> 
  resp_body_json()

candidates_single

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

# OHIO

  'https://api.open.fec.gov/v1/candidate/S4OH00226/totals/?page=1&per_page=20&election_full=true&sort=-cycle&sort_hide_null=false&sort_null_only=false&sort_nulls_last=false&api_key=DEMO_KEY' \

candidate_id  <- "SOH00226"

candidates_request <-
  request(paste0("https://api.open.fec.gov/v1/candidate/", candidate_id, "/totals")) |> 
  req_url_query(api_key=api_key, election_full=TRUE)
candidates_request

candidates_single <- 
  candidates_request |> 
  req_perform() |> 
  resp_body_json()

candidates_single
library(tibblify)
tibblify(candidates_single)
