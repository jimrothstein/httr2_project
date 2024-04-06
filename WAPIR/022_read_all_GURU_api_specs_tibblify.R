022_read_all_GURU_api_specs_tibblify.R


# ---------------------------
## SEE jon's video at 12;00
# https://www.youtube.com/watch?v=kXFWombsGl4
# ---------------------------
##  PURPOSE: Using a json file (of api specs); tibblify
library(jsonlite)
library(tibblify)

# -----------------
##  tibblify GURU, but we use subset ...
# -----------------
all_apis<- readRDS(file = "all_apis.RDS")
enframe(all_apis)
 tibblify::tibblify(all_apis)


# ------------------------------------------------------------
BUT...
Jon created a subset of all_apis from guru: "demo_json.json"
Note:  yaml is a SUPERSET of JSON
yaml=humnas
JSON=machines to read
# ------------------------------------------------------------
# file comes from jon's wapir github (i already downloaded it here)
# it is NeSTED LIST
demo_json  <- jsonlite::fromJSON("./demo_json.json")
is_tibble(demo_json) # [1] FALSE
is.data.frame(demo_json) # [1] FALSE

z = tibblify(demo_json)
z |> dplyr::rename("api_names" = ".names")   # because .names is used, multi-level
z |> dplyr::rename("api_names" = ".names")   |>
  tidyr::unnest_wider(versions)


# ---------------------------------------------
## Manual (tidyr) vs tibblify
## Can use waldo:: to verify OBJECTS are same
# ---------------------------------------------

