#  024_from_api_docs_create_tspecs_for_tibblify.R

# -----------------------------------------------------------------------------------------------------------------
PURPOSE                                             
Given a json file with 1 or more api specs (from apis.guru), use tibblify to put specs like different api/versions/various links (nothing to do with endpoints)                                            

REF:   Jon's video #3
Using: demo_json.json (shorten version of FULL apis.guru - only 3 apis)
# -----------------------------------------------------------------------------------------------------------------

library(tibblify)

demo_json  <- jsonlite::fromJSON("~/code/httr2_project/WAPIR/demo_json.json")

# ---------
## TO SEE, and read
# apis.guru in yaml: https://github.com/APIs-guru/openapi-directory/blob/main/APIs/apis.guru/2.2.0/openapi.yaml
# ---------

# Begin  #components/schemas/APIs 

# -----------------
# 1) df of api_id,  holds all the apis ...
# -----------------
# @29:02 tspec_apis (from reading schema)
tspec_apis  <- tspec_df(
  .names_to  = "api_id",              # from reading schema 
  tspec_api)                           # tells to look #$ref/components/schemas/API 

# ------------------------------------------------------------
# 2) Each api,  is row (and each holds 1 more verions )
# ------------------------------------------------------------
# @32:29
tspec_api <- tspec_row(
  tib_df(
    "versions", 
    .names_to = "version", 
    tspec_api_version
  )
)
# 33:58
# 36:13
tib_chr_datetime <- function(key, ..., required = TRUE) {
  tibblify::tib_scalar(
    key = key,
    ptype = vctrs::new_datetime(tzone = "UTC"),
    required = required,
    ptype_inner = character(),
    transform = \(x) as.POSIXct(x, format = "%Y-%m-%dT%H:%M:%OSZ", tz = "UTC"),
    ...
  )
}
# ----------------------
# Each version, is row
# ----------------------
# @36.53
 tspec_api_version <- tspec_row(
  tib_chr_datetime("added"),
  tib_chr_datetime("updated"),
  tib_chr("openapiVer"),
  tib_chr("swaggerUrl"),
  tib_chr("swaggerYamlUrl"),
#  tib_chr("externalDocs"),  # not included in demo_json
  tib_chr("link", required = FALSE)
)                                                

# ----------------------------------------------------------------------
## one specific version:   most specfic, least amount of manual tspecs
# ----------------------------------------------------------------------
tibblify(demo_json$apis.guru$versions$`2.2.0`, tspec_api_version)
tibblify(demo_json$fec.gov$versions$`1.0`, tspec_api_version)
names(demo_json$fec.gov$versions$`1.0`)
# ----------------------------------------------
# 
# ----------------------------------------------
# one api, all versions
# tidyr::unnest is when column is a dataframe.
# ----------------------------------------------
tibblify(demo_json$apis.guru, tspec_api) |> tidyr::unnest(versions)

# @38:01
# --------------------------------------------------------
#  All the apis (here 3) - all manual tspecs must 1st be in place
# --------------------------------------------------------
tibblify(demo_json, tspec_apis) |> tidyr::unnest(versions)
str(demo_json, max.level=2)
                                                 source:    Jon's video (at 31:29)

