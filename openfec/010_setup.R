##  fakerapi.it
library(httr2)

req <- request("https://fakerapi.it/api/v1")
resp <- req |>
  # Then we add on the images path
  req_url_path_append("images") |>
  # Add query parameters _width and _quantity
  req_url_query(`_width` = 380, `_quantity` = 1) |>
  req_perform()

resp |>
  resp_body_json() |>
  str()



candidates <-
  request("https://api.open.fec.gov/v1") |>
  req_url_path_append("candidates") |>
  req_url_query(api_key = "DEMO_KEY") |>
  req_url_query(election_year = 2024) |>
  req_perform() |>
  resp_body_json()

candidates$results[[1]]$candidate_id
candidates$results[[1]]$name
candidates$results[[2]]$candidate_id
candidates$results[[3]]$candidate_id
candidates$results[[3]]$name

candidates$results[[1]]
z <- candidates$results
length(z)
# [1] 20

# lapply to pluck every one
tibble(
  id = unlist(lapply(1:length(z), \(x) pluck(z, x, 2))), # candidate_id
  name = unlist(lapply(1:length(z), \(x) pluck(z, x, "name")))
) # candidate_id

# ---------------------------
## get trump's candidate_id
# ---------------------------
z <-
  request("https://api.open.fec.gov/v1") |>
  req_url_path_append("candidates/search") |>
  req_url_query(api_key = "DEMO_KEY") |>
  req_url_query(election_year = 2024) |>
  req_url_query(name = "Trump") |>
  req_perform() |>
  resp_body_json()
glimpse(z)

z$results[[1]]$name
z$results[[1]]$candidate_id
# [1] "P80001571"

##  returns only 1st 20 ppl/ 1336 total (67 pages x 20 approx)
resp <-
  request("https://api.open.fec.gov/v1") |>
  req_url_path_append("candidates/search") |>
  req_url_query(api_key = "DEMO_KEY") |>
  req_url_query(election_year = 2024) |>
  req_url_query(office = "P") |>
  req_perform() |>
  resp_body_json()
glimpse(resp)

z <- resp$results
length(z)
z[[1]]$candidate_id
# [1] "P40014052"
z[[1]]$name
# [1] "212 N HALF  W. JOHN, RODNEY HOWARD MR."

lapply(1:length(z), \(x) pluck(z, x, "name"))
lapply(1:length(z), \(x) pluck(z, x, "candidate_id"))
