# 010_nested_json_from_apis_guru.R

# ----------------------------------------------------------
# Purpose:   Retrieve all apis listed in  apis.guru (many), in JSON format
# ----------------------------------------------------------
# TODO:
#   - import only if RDS file not found
##  2024-02-29
library(jsonlite)

if (!file.exists("all_apis.RDS")) {
  # jsonLite can accept url: https://apis.guru/api-doc/#operation/listAPIs
  all_apis <- jsonlite::fromJSON("https://api.apis.guru/v2/list.json")
  # write_json works and can then be in browser
  jsonlite::write_json(all_apis, path = "all_guru_apis_json.json")

  saveRDS(file = "all_apis.RDS", object = all_apis)
}

all_apis <- readRDS(file = "all_apis.RDS")

testthat::expect_true(
  identical(x, all_apis)
)

length(all_apis) # [1] 2529

purrr::pluck_depth(all_apis) # [1] 10, nested as deep as 10 levels!
head(names(all_apis))

str(all_apis, max.level = 2)

## 1st api entry
str(all_apis[1], max.level = 2)
