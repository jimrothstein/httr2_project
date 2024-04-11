050_openfec_api.R
# Purpose:   R code  to retreive from openFEC
#             Mostly taken from Jon's slides
# ----------------------------------------------------------
library(jsonlite)
library(tibblify)
library(httr2)

## could use fromJSON(<url>), but this hardcoding requests

# --------------------------------------------------------------
### NOTE:   Nicely builds up request, reuseable piece by piece
# --------------------------------------------------------------
### - DO use req_url_path_append
### - DO NOT use req_url_path  (issue:  extra `/v1` gets confused)
### - CAN USE req_url_query more than once

req_fec <- request("https://api.open.fec.gov/v1")
req_fec_auth <- req_url_query(req_fec, api_key = "DEMO_KEY")
req_candidates <- req_url_path_append(req_fec_auth, "candidates")
req_candidates_president <- req_url_query(req_candidates, office = "P")
pres_2024 <- req_url_query(req_candidates_president, election_year = 2024) |> 
  req_perform() |> resp_body_json()

# not just pres
candidates_2022 <- req_url_query(req_candidates, election_year = 2022) |> 
  req_perform() |> resp_body_json()

## so nice
tibblify(pres_2024)


# -------------------------------
## example:  reuse `req_fec_auth` to create completely separate request
# -------------------------------
req_calendar <- req_url_path_append(req_fec_auth, "calendar-dates")
calendar  <- req_url_query(req_calendar) |> req_perform() |>resp_body_json()
tibblify(calendar)
