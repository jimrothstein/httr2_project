# Purpose:   Retrieve all apis listed in  apis.guru (many)

# ----------------------------------------------------------
# Purpose:   Retrieve all apis listed in  apis.guru (many), in JSON format
# ----------------------------------------------------------
# TODO:
#   - import only if RDS file not found
##  2024-02-29
library(jsonlite)

# stored in json format
if (!file.exists("all_apis.RDS")) {
  # jsonLite can accept url: https://apis.guru/api-doc/#operation/listAPIs
  all_apis <- jsonlite::fromJSON("https://api.apis.guru/v2/list.json")
  saveRDS(file = "all_apis.RDS", object = all_apis)
}

all_apis <- readRDS(file = "all_apis.RDS")


# read_yaml requires (1) stored in a file (2) be in yaml/json format
z <- yaml::read_yaml(file = "~/code/httr2_project/WAPIR/all_apis_yaml.yaml")
## THIS is where fun starts
tibblify(z)

## write as yaml
yaml::write_yaml(x = readRDS(file = "all_apis.RDS"), file = "all_apis_yaml.yaml")
