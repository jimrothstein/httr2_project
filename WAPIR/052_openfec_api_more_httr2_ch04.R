052_openfec_api_more_httr2.R
# Jon's video 10April2024;  Beginning @24:11 (mulit)  Jon's says Chapter 04
library(httr2)

# --------------------------------------
#    .multi
# req_url_query(.req, ..., .multi = c("error", "comma", "pipe", "explode"))
# modify query

# --------------------------------------

req_candidates_president <- req_url_query(req_candidates, office = c("P", "S"), .multi=c("pipe"))

# SHOW  (NOTE:   in case of openfed,  .multi="explode") b/c appears to want array
req_candidates_president


# END of Chapter 04
