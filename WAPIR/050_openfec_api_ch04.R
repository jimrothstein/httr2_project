050_openfec_api.R
# Purpose:   R code  to retreive from openFEC
#             Mostly taken from Jon's slides
# ---------------------------------
video:  10April2024 @12:17
begins:  Chapter 04 
topic: httr2
# ---------------------------------

# ----------------------------------------------------------
library(jsonlite)
library(tibblify)
library(httr2)

# ----------------------------------------------------------
## 1 method:   fromJSON(<url>), but this hardcoding requests
# TODO:   try tib_variant("inactive_election_years"); casts field to list
# ----------------------------------------------------------
# Wyden, OR, Senate
url = "https://api.open.fec.gov/v1/candidates/?page=1&per_page=20&q=Wyden&election_year=2022&office=S&state=OR&sort=name&sort_hide_null=false&sort_null_only=false&sort_nulls_last=false&api_key=DEMO_KEY"

z=jsonlite::fromJSON(url)

# 1 field "inactive_election_year" is unspecified ??
tibblify(z$results, unspecified="drop") |> select(name)

# --------------------------------------------------------------
### NOTE:   @12:17 Nicely builds up request, reuseable piece by piece
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

tibblify(pres_2024$results) # chop off leading info

# -------------------------------------
# How tibblify did it.
get_spec(tibblify(pres_2024$results))
# -------------------------------------

# @ 12:34 Pipe:  Shorter versions
candidates  <- 
  request("https://api.open.fec.gov/v1") |>
  req_url_query(api_key="DEMO_KEY")    # TODO:  replace with my KEY 

# -------------------------------
## example:  reuse `req_fec_auth` to create completely separate request
# -------------------------------
req_calendar <- req_url_path_append(req_fec_auth, "calendar-dates")
calendar  <- req_url_query(req_calendar) |> req_perform() |>resp_body_json()
tibblify(calendar)


##  END:  Jon moves on to httr2 discussion
