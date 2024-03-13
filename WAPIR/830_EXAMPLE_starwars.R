library(dplyr)

TAGS: dplyr, select, mutate, across

# 5 columns of atomic, last 3 list-columns
str(starwars, max.level = 2)

head(starwars)
starwars %>%
  select(name, films, vehicles, starships) %>%
  rowwise() %>%
  mutate(across(c(films, vehicles, starships), toString))

starwars %>%
  select(name, films, vehicles, starships)

starwars %>%
  select(name, films, vehicles, starships) |>
  dplyr::rowwise() # each row, convert to df?


##  toString concatentates
L <- as.list(letters[1:5])
dput(L) # list("a", "b", "c", "d", "e")
toString(L) # [1] "a, b, c, d, e"

starwars |>
  select(name, films, vehicles, starships) |>
  dplyr::rowwise() |>
  mutate(across(c(films, vehicles, starships), base::toString)) # apply `toString`
