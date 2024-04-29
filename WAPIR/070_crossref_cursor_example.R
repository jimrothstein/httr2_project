070_crossref_cursor_example.require

PURPOSE:  Jon's crossref example (using cursor to repetitively return api data)

library(httr2)

REF:   https://api.crossref.org/swagger-ui/index.html

##  CAUTION:   lot of data,  do not run or LIMIT.

# -------
ENDPT: 
search for 'apis'
# -------

https://api.crossref.org/works?filter=has-full-text:true&mailto=GroovyBib@example.org

# ---------------------------------------------------------------------------------------------------------------------------------
User-Agent header. For example: GroovyBib/1.1 (https://example.org/GroovyBib/; mailto:GroovyBib@example.org) BasedOnFunkyLib/1.4.
# ---------------------------------------------------------------------------------------------------------------------------------

crossref_request <- 
request("https://api.crossref.org/works") |> 
  req_url_query(query = "apis") |>
  req_url_query(mailto="jimrothstein@gmail.com") |>
  req_headers(email="jimrothstein@gmail.com") |>
  req_user_agent("package: wapir, httr2, mailto: jimrothstein@gmail.com")
crossref_request

# -----------------
#A  initial request & response
# -----------------
crossref_single <- 
  crossref_request |> 
  req_perform() |> 
  resp_body_json()

# ----------------------
# probe:   useful info
# ----------------------
names(crossref_single)
names(crossref_single$message)
crossref_single$message$`items-per-page` # [1] 20
crossref_single$message$`total-results` #> [1] 14114

length(crossref_single$message$items) #> [1] 20

# 

# ---------------------------------------------------------------
##B  Crossref API notes:   do not want you to use offset methods
##  do use cursor methods
# ---------------------------------------------------------------
 
.rs = function(resp){
        content <- resp_body_json(resp)
        content$pagination$message$`total-results`
}
# DO NOT RUN,   very long time, excessive load
crossref_multi <- 
  crossref_request |> 
  req_retry(max_tries = 3) |> 
  req_perform_iterative( 
                        STOP
    next_req = iterate_with_offset( "offset", 
                resp_pages = \(resp) { 
                  content <- resp_body_json(resp) 
                  content$pagination$message$`total-results` 
                }
    ),
    max_reqs = Inf)

length(crossref_multi) #> [1] 706

## STOP
# ---------------------------------------------
# ## C Iteration helpers: iterate_with_cursor()
# ---------------------------------------------

-   `param_name` = `"cursor"` or whatever API calls it
-   `resp_param_value` = function to convert `resp` to next cursor
    -   `NULL` if no more pages

::: notes
-   I've seen "cursor", "token" and variations, like "nextPageToken".
-   Single function because usually this style ends with an empty `nextCursor`.
:::

# ---------------------------
## D Cursor example: Crossref
# ---------------------------

# set up request
crossref_request <- 
request("https://api.crossref.org/works") |> 
  req_url_query(query = "apis") |>
  req_url_query(mailto="jimrothstein@gmail.com") |>
  req_headers(email="jimrothstein@gmail.com") |>
  req_user_agent("package: wapir, httr2, mailto: jimrothstein@gmail.com")

crossref_request

# make it use cursor
crossref_request_cursor <- 
  crossref_request |> 
  req_url_query(cursor = "*")
crossref_request_cursor

# run 1st time
crossref_single <- 
  crossref_request_cursor |> 
  req_perform() |> 
  resp_body_json()

# -------
# probe
# -------
names(crossref_single)
names(crossref_single$message)
#> [1] "facets"         "next-cursor"    "total-results"  "items"          "items-per-page"
#> [6] "query" 
crossref_single$message$`next-cursor`
crossref_single$message$`total-results`
crossref_single$message$`items`
crossref_single$message$`items-per-page`  

# ------
# TODO:  iterate, using cursor and WITH counter; where are responses?
 # ------
e = new.env(emptyenv())
e$counter = 0
crossref_multi <- 
  crossref_request_cursor |> 
  req_retry(max_tries = 3) |> 
  req_perform_iterative(
    next_req = iterate_with_cursor(
      "cursor",
      resp_param_value = \(resp) {
        content <- resp_body_json(resp)
        #browser()
        if (!length(content$message$items)) {
          return(NULL)
        }
        if (e$counter > x) {
          return(NULL)
        } else {
          e$counter = e$counter+1
          content$message$`next-cursor`
      }
      }
    ),
    max_reqs = Inf
  )
length(crossref_multi)
names(crossref_multi)
crossref_multi
#> [1] 706

# -----------
# a counter
# -----------
e=NULL
e = new.env(parent=emptyenv())
e$counter = 0


f  <- function(){
  e$counter = e$counter + 1
  cat(e$counter, "\n")
}
f()
