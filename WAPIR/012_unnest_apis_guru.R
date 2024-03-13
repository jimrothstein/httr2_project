## 012_unnest_apis_guru.R

library(tidyr)
library(testthat)
if (file.exists("all_apis.RDS")) {
  print("reading from stored file")
  all_apis <- readRDS("all_apis.RDS")
}



# rectangle  (compare:   enframe(unlist(app_apis)))
z <- enframe(all_apis)
z


# examine each row, number of elements in $value
z$value |> lengths()

# all the same length? yes
z$value |>
  lengths() |>
  unique() # 3



##  T if every elment is named
rlang::is_named(z$value) # [1] FALSE     WHICH IS FALSE?
elements <- sapply(z$value, rlang::is_named)

any(elements)
all(elements) # [1] TRUE

head(elements)
length(elements) # [1] 2529

str(elements, max.depth = 2)
sapply(elements, is_named)
elements[sapply(elements, is_named) != T]
length(elements)

names(z$value[[1]])
length(names(z$value[[1]]))

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


## Jon does another way
z <- all_apis |>
  enframe(name = "api_name") |>
  unnest_wider(value) |>
  unnest_longer(versions, indices_to = "version") |>
  dplyr::filter(preferred == version) |>
  dplyr::select(api_name, version, versions)

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
