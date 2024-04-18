/home/jim/code/httr2_project/WAPIR/060_lot_of_data_ch05.R

# ---------------------------------
video:  10April2024 
begins:  Chapter 05 (lot of data)
@27:00
#   PAGINATION, multiple pages, 
# ---------------------------------


# pagination stratgies (several)
# ---------------------------------------
# crossref.org, uses offset and cursor 
# https://api.crossref.org/swagger-ui/index.html
# ---------------------------------------

# ------------
# Jon's explains some of strategies, no code, but shows examples from  api docs
# @38:00  link to next set (ex: github)
# ------------

#
# ------------
# body links
# ------------



# -------------------------------------
# @ 45:00   Don't hit server too much !
# max retries;  time to delay;  many options
# -------------------------------------


# ---------------------------------------------------
# @51:00
# httr2::req_perform_iterative
# replace req_preform;  ways to slow hitting server
# HELPERS:   iterative_with_offset
# ---------------------------------------------------

# ----------------------
# EXAMPLE with openfec
# ----------------------

candidates  <- 
  request("https://api.open.fec.gov/v1/candidates") |>
  req_url_query(api_key="DEMO_KEY", office="P", election_year=2020)    |>
  req_url_query(has_raised_funds=TRUE)
candidates

candidates_single  <- 
candidates |>
req_perform() |>
resp_body_json() 

names(candidates_single)
names(candidates_single$results)
# a lot
candidates_single$results[[1]]  
length(candidates_single$results[[1]]  )
names(candidates_single$pagination)

# ----------
NEXT: TODO
# ----------
56:00
length(candidates_single$results) # [1] 20
candidates_single$pagination$count # [1] 173

