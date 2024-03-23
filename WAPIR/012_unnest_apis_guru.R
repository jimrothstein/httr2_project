# 012_unnest_apis_guru.R

# TODO (2024-03-21)
# - separate probing/tools from actual unnest

library(tidyr)
library(testthat)
if (file.exists("all_apis.RDS")) {
  print("reading from stored file")
  all_apis <- readRDS("all_apis.RDS")
}



# ---------------------------------------------------
# rectangle  (compare:   enframe(unlist(app_apis)))
# ---------------------------------------------------
z <- enframe(all_apis)
z


# ------------------------------------------------
#       wider or longer?   PROBE
#       each row named?  same number of names?
# ------------------------------------------------

# -----------------------
#       examine 1st row
# -----------------------
if (F) {
  str(z$value[[1]])
}
z$value[[1]] |> length() # [1] 3
z$value[[1]] |> lengths() # length of EACH element in 1st
#     added preferred  versions
#         1         1         1

# ------------------------------------------
# Every row, each all the same length? yes
# ------------------------------------------
z$value |>
  lengths() |>
  unique() # 3

if (F) { # (versions) even 1st row is deeply nested
  dput(z$value[1])
}
#


# --------------------------------
#   EACH row, all elemnts named?
# --------------------------------
##  This is checking the z$value list, not elments we want
rlang::is_named(z$value) # [1] FALSE     WHICH IS FALSE?


# EACH row, T or F?  all are T
elements <- sapply(z$value, rlang::is_named)
length(elements) # [1] 2529
all(elements) # [1] TRUE

elements[elements != T] # logical(0);   none are F
elements[elements == T]

# MORE checks
##  Grab non-empty (actually none are empty)
non_empties <- z$value[lengths(z$value) > 0]
empties <- z$value[lengths(z$value) == 0] #  0


length(empties)
length(non_empties) # [1] 2529

## get names
head(non_empties)
element_names <- purrr::map(non_empties, names)
element_names1 <- lapply(non_empties, names)
identical(element_names, element_names1)

## any names NULL?  no, all are named
has_null <- unique(purrr::map_lgl(element_names, is.null))
# [1] 0
has_null
map(element_names, is.null) |> is.null()

purrr::reduce(element_names, intersect) # added, preferred, versions


# All rows and all elements of z$value are NAMED => unnest_wider
unnest_wider(z, col = value)



## Summary


all_apis_df <- enframe(all_apis)
all_apis_df
all_apis_versions <- all_apis_df |> tidyr::unnest_wider(value)
all_apis_versions

## versions are not nicely arranged.
all_apis_versions$versions |> lengths()
all_apis_versions$versions |>
  lengths() |>
  unique()

## not what we want, not candidate for adding columns
all_apis_versions |> unnest_wider(versions)

## b/c observations !
all_apis_versions |> unnest_longer(col = versions)
aapw <- all_apis_versions |> unnest_longer(col = versions)

## move to 013_
aapw$versions[[1]]

# ----------
#   Method
# ----------
## Jon does another way
all_apis_versions <- all_apis |>
  enframe(name = "api_name") |>
  unnest_wider(value) |>
  unnest_longer(versions, indices_to = "version") |>
  dplyr::filter(preferred == version) |>
  dplyr::select(api_name, version, versions)

head(all_apis_versions)


# --------------------------
##  NEXT:   probe versions
# --------------------------
## Jon uses this name.
all_apis_versions <- z

lengths(z$versions) |> unique()
# [1] 7 8

head(lengths(z$versions))
length(z$versions[[1]])
# [1] 7
length(z$versions[[7]])
# [1] 8

base::setdiff(list(a = 1), list(b = 1))
base::union(
  names(z$versions[[1]]),
  names(z$versions[[7]])
)
## bingo
names(z$versions[[1]])
names(z$versions[[7]]) # has "externalDocs"

z$versions |> lengths()
unnest_wider(versions)
