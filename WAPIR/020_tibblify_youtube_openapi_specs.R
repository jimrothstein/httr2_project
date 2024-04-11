020_read_api_specs_tibblify.R

# -----------------------------------------------
##  Read specs in YAML format; returns R object
# -----------------------------------------------
apisguru_spec <- yaml::read_yaml("https://api.apis.guru/v2/specs/apis.guru/2.2.0/openapi.yaml")
str(apisguru_spec, max.level=2)

# ----------------------------------------
# Example:  tifflify youtube's api specs
# 1.  GET the API specs (in yaml)
# ----------------------------------------
youtube_spec <- yaml::read_yaml("https://api.apis.guru/v2/specs/googleapis.com/youtube/v3/openapi.yaml")

str(youtube_spec, max.level=2)
str(youtube_spec, max.level=1)

# ------------------------
# Introduction to tibblify
# 2. Rectangle a portion of youtube's API specs (paths)
# ------------------------

## REF:
## https://r4ds.github.io/bookclub-wapir/slides/httr2/openapi.html#/introduction-to-tibblify

TODO: Use tibblify to get response specs, and then use that to tibblify responses. Show without the spec (messy) and then in theory it SHOULD get the ~same result as previous slides with spec.

# check structure, $paths is list of 39
# ------------
# 3. Glimpse - a lot specs
# ------------
youtube_paths <- tibblify::tibblify(youtube_spec$paths) |> 
  dplyr::glimpse()

#> Rows: 39
#> Columns: 6
#> $ .names     <chr> "/youtube/v3/abuseReports", "/youtube/v3/activities", "/you…
#> $ parameters <list<tibble[,1]>> [<tbl_df[11 x 1]>], [<tbl_df[11 x 1]>], [<tbl_…
#> $ post       <tibble[,7]> <tbl_df[26 x 7]>
#> $ get        <tibble[,6]> <tbl_df[26 x 6]>
#> $ delete     <tibble[,6]> <tbl_df[26 x 6]>
#> $ put        <tibble[,7]> <tbl_df[26 x 7]>


# ------------------
# 4.  but we can see beginnings of the OpenAPI References for Youtube
# ------------------

youtube_paths$parameters[[1]]

#> # A tibble: 11 × 1
#>    `$ref`                                 
#>    <chr>                                  
#>  1 #/components/parameters/_.xgafv        
#>  2 #/components/parameters/access_token   
#>  3 #/components/parameters/alt            
#>  4 #/components/parameters/callback       
#>  5 #/components/parameters/fields         
#>  6 #/components/parameters/key            
#>  7 #/components/parameters/oauth_token    
#>  8 #/components/parameters/prettyPrint    
#>  9 #/components/parameters/quotaUser      
#> 10 #/components/parameters/upload_protocol
#> 11 #/components/parameters/uploadType

r4ds.io/wapir | Jon Harmon | wapir.io
