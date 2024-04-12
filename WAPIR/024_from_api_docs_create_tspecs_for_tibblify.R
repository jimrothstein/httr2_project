#  024_from_api_docs_create_tspecs_for_tibblify.R

# -----------------------------------------------------------------------------------------------------------------
PURPOSE:  Put things together:   read api specs (guru's own API spec); create tspec so tibblify knows what to do.
REF:   Jon's video #3
Using: demo_json.json (shorten version of FULL apis.guru - only 3 apis)
# -----------------------------------------------------------------------------------------------------------------

library(tibblify)

demo_json  <- jsonlite::fromJSON("~/code/httr2_project/WAPIR/demo_json.json")


# @29:02 tspec_apis (from reading schema)
tspec_apis  <- tspec_df(
  .names_to  = "api_id",              # from reading schema 
  tspec_api)                           # tells to look #$ref/components/schemas/API 

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
tibblify(demo_json$apis.guru$versions$`2.2.0`, tspec_api_version)

# tidyr::unnest is when column is a dataframe.
tibblify(demo_json$apis.guru, tspec_api) |> tidyr::unnest(versions)

# @38:01
#  all the apis
tibblify(demo_json, tspec_apis) |> tidyr::unnest(versions)
str(demo_json, max.level=2)
                                                 source:    Jon's video (at 31:29)

