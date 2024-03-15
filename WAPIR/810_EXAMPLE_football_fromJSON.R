# 810_EXAMPLE_football_fromJSON.R

# TODO: (2024-03-15)
# - Pursue unnesting, using modern rlang, vctrs as guides
# - Possible this may be harder than average
# - Use revealjs - ONCE my code is stable.

library(tidyr)
library(jsonlite)
library(stringr)

# TAGS:  tidyr, separate,

#   PURPOSE:  Retangle deeply nested lists.

#   USES separate_* functions that split composite columns (jan-week1-total) into separate columns

# REF: R-bloogers, another approach to deeply nested
# https://www.r-bloggers.com/2018/10/converting-nested-json-to-a-tidy-data-frame-with-r/

## Get data
url <- "http://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard?&dates=2018&seasontype=2&week=1"
football <- jsonlite::fromJSON(url)

## rectangle
data_raw <- tibble::enframe(unlist(football))
head(data_raw)

##  How many columns are wrapped into name? (7)

# guess
data_raw %>% separate(name, into = c(paste0("x", 1:10)), fill = "right")


pull(data_raw, name) |>
  stringr::str_split(rgx_split) |>
  purrr::map_dbl(~ length(.)) |>
  max()

## breakout of code above

nrow(data_raw)
pull(data_raw, name)
pull(data_raw, name) |> stringr::str_split(rgx_split)
pull(data_raw, name) |>
  stringr::str_split(rgx_split) |>
  purrr::map_dbl(~ length(.))

##
rgx_split <- "\\."
n_cols_max <-
  data_raw %>%
  pull(name) %>%
  stringr::str_split(rgx_split) %>%
  map_dbl(~ length(.)) %>%
  max()
n_cols_max

## split names (correct way)
nms_sep <- paste0("name", 1:n_cols_max)
data_sep <-
  data_raw %>%
  separate(name, into = nms_sep, sep = rgx_split, fill = "right")
data_sep


# ----------------------
##  post-process  STOP
# ----------------------

## Redo smarter way?  4 rows
x <- enframe(football)
x

##  examine rows
x$value[[1]]
x$value[[2]]
x$value[[3]]


## Unnest row 1   all names, suggest WIDER
names(x$value[[1]])
attributes(x$value[[1]])
rlang::is_named(x$value[[1]])


# x[1,]   |> unnest_wider(value )
x[1, ] |> unnest_longer(value)
