# 810_from_JSON.R

library(tidyr)
library(testthat)
library(jsonlite)

# TAGS:  tidyr, separate,

#   PURPOSE:  Retangle deeply nested lists.

#   USES separate_* functions that split composite columns (jan-week1-total) into separate columns

# REF: R-bloogers, another approach to deeply nested
# https://www.r-bloggers.com/2018/10/converting-nested-json-to-a-tidy-data-frame-with-r/

url <- "http://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard?&dates=2018&seasontype=2&week=1"
football <- jsonlite::fromJSON(url)


# rectangle
z <- enframe(football)
z1 <- enframe(unlist(football))

## all levels/names ?
z2 <- unlist(football)
names(z2)
head(z2)

head(z)
head(z1)

# --------
# LEGACY
# --------

##  T if every elment is named
rlang::is_named(z$value) # [1] FALSE
elements <- sapply(z$value, is_named)
head(elements)
length(elements)

str(elements, max.depth = 2)
sapply(elements, is_named)
elements[sapply(elements, is_named) != T]
length(elements)

names(z$value[[1]])
length(names(z$value[[1]]))

##  Grab non-empty (actually none are empty)
non_empties <- z$value[lengths(z$value) > 0]
length(non_empties) # [1] 2529

## get names
head(non_empties)
element_names <- purrr::map(non_empties, names)
element_names1 <- lapply(non_empties, names)
identical(element_names, element_names1)

## any names NULL?  no, all are named
has_null <- unique(purrr::map_lgl(element_names, is.null))
has_null
map(element_names, is.null) |> is.null()


purrr::reduce(element_names, intersect) # added, preferred, versions

# All rows and all elements of z$value are NAMED => unnest_wider
unnest_wider(z, col = value)


all_apisgg




all_apis_df <- enframe(all_apis)
all_apis_df
all_apis_versions <- all_apis_df |> tidyr::unnest_wider(value)
all_apis_versions

##  only versions is list, but not all equal
