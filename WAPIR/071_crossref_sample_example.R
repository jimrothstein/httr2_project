071_crossref_sample_example.R

library(httr2)

# ------------------------
#   sample = 3,   limits
#    NOTE:   sample does NOT work with cursor
# ------------------------

crossref_request <-
  request("https://api.crossref.org/works") |>
  req_url_query(query = "apis") |>
  req_url_query(sample = "3") |>
  req_url_query(mailto = "jimrothstein@gmail.com") |>
  req_headers(email = "jimrothstein@gmail.com") |>
  req_user_agent("package: wapir, httr2, mailto: jimrothstein@gmail.com")
crossref_request

# -------------
# run saomple
# -------------
crossref_sample <-
  crossref_request |>
  req_perform() |>
  resp_body_json()

# --------------
# probe sample
# --------------
names(crossref_sample)
# probe:   useful info
crossref_sample$message$`items-per-page` # [1] 20
crossref_sample$message$`total-results` #> [1] 14114

length(crossref_sample$message$items) #> [1] 3
crossref_sample$message$items[1]
crossref_sample$message$items[[1]]
