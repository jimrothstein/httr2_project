055_openfec_api_JON_fecapi_library.R

## Use Jon's fecapi library to call openfec api
library(fecapi)


# ------------
# no errors 
# ------------
fec_get_candidates() |> head()

fec_get_candidates(office = "P") |> head()
