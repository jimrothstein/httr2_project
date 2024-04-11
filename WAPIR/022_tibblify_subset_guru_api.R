022_read_all_GURU_api_specs_tibblify.R


# ---------------------------
## SEE jon's video at 12;00
# https://www.youtube.com/watch?v=kXFWombsGl4
# ---------------------------
# -------------------------------------------------------
##  PURPOSE: Using a json file (of api specs); tibblify (he uses demo_json.json)
##  demo_json.json is SMALL subset of guru api

##  tibblify does MOST heavy lifting, not perfect, some manual tuning may be needed
# -------------------------------------------------------
library(jsonlite)
library(tibblify)

# -----------------
##  tibblify GURU
# -----------------
all_apis<- readRDS(file = "all_apis.RDS")
enframe(all_apis)
 tibblify::tibblify(all_apis)


# ------------------------------------------------------------
BUT...
Jon created a subset of all_apis from guru: "demo_json.json"
Note:  yaml is a SUPERSET of JSON
yaml=humans
JSON=machines to read
# ------------------------------------------------------------
# "demo_json.json" file comes from jon's wapir github (i already downloaded it here)
# it is NeSTED LIST
demo_json  <- jsonlite::fromJSON("~/code/httr2_project/WAPIR/demo_json.json")

# ---------------------
## tibblify demo_json
## only 3 apis (in demo_json), versions is list of tibbles
# ---------------------
# 
z = tibblify(demo_json) # 3 x 2

z
## fix/change .names
z |> dplyr::rename("api_names" = ".names")   # because .names is used, multi-level

# unnest list of tibbles; now 3 x 8 
result  <- z |> dplyr::rename("api_names" = ".names")   |>
  tidyr::unnest_wider(versions)
result

# ---------------------------------------------
## Manual (tidyr) vs tibblify
## Can use waldo:: to verify OBJECTS are same
# ---------------------------------------------

