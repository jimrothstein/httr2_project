library(tidyr)
library(testthat)
library(jsonlite)
library(vctrs)

# TAGS:  tidyr, separate, vctrs::, vec_as_names, rlang::names2

#   PURPOSE:  Retangle deeply nested lists.
#   vctrs::  helps , esp with names

## https://vctrs.r-lib.org/reference/vec_as_names.html

# setup 2 lists, names() = NULL
L <- list(1, 2, 3)
M <- L
identical(L, M) # [1] TRUE
identical(names(L), NULL) # [1] TRUE


##  convert names from NULL to  ""
rlang::names2(L) # [1] "" "" ""
(names(M) <- rlang::names2(L)) # [1] "" "" ""

identical(L, M) # [1] FALSE


# throws error, L has NULL names, can not use this
tryCatch(
  vctrs::vec_as_names(names(L), repair = "minimal"),
  error = function(e) print(paste0(" NOPE .. threw an error:", e))
)


##  create named list where names were NULL
vctrs::vec_as_names(rlang::names2(L), repair = "minimal") # [1] "" "" ""
vctrs::vec_as_names(rlang::names2(L), repair = "unique") # [1] "...1" "...2" "...3"
