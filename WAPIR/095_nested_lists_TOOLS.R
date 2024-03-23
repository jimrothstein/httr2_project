# Given a tibble of list-columns, find  names informatino.



df <- tibble(
  x = 1:5,
  y = c(1:4, list(x1 = "a")), # named list, even if just 1 is named
  z = c(1:4, list("a")),
  zz = list(1:5), # <list-column>
  ww = c(1:5) # regular column
)
df
attributes(df)


library(rlang)

# --------
# the df
# --------
# df columns are named
rlang::is_named(df) # [1] TRUE
rlang::is_named(mtcars) # [1] TRUE
rlang::has_name(df, "x") # [1] TRUE


rlang::has_name(df, "x1") # df object, does not have "x1"  name
# [1] FALSE



# ------
# colums
# ------
rlang::is_named(df$x) # [1] FALSE
sapply(df, rlang::is_named) # each column
#     x     y     z    zz    ww
# FALSE FALSE FALSE FALSE FALSE


sapply(df, rlang::has_name, "x1") # only col y does
#     x     y     z    zz    ww
# FALSE  TRUE FALSE FALSE FALSE

rlang::is_named(df$y) # [1] FALSE

# -------
## rows
# -------
rlang::is_named(df$y[5]) # [1] TRUE
df$y[5] # $x1
# [1] "a"

rlang::is_named(df$y[[5]]) # [1] FALSE
rlang::is_named(df$y[[5]][1]) # [1] FALSE
rlang::is_named(df$y[[5]][[1]]) # [1] FALSE
