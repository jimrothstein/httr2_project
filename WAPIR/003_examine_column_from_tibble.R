## Subset tibble vs extract column contents
t <- tibble(
  a = c(1, 2),
  b = c(11, 12)
)
is_tibble(t) # [1] TRUE


# compare t$b, t[, 2] , t[, "b"]  - SAME
# compare  t[["b"]], t[, 2], t[, "b"] - NOT

# subset a tibble returns tibble
identical(t[, 2], t[, "b"]) # [1] TRUE

# BUT ...
identical(t$b, t[, 2]) # [1] FALSE
typeof(t$b) # [1] "double"

# extact content so column is vector
identical(t[["b"]], t[, 2]) # [1] FALSE
identical(t$b, t[["b"]]) # [1] TRUE

is.list(t[["b"]]) # [1] FALSE
typeof(t[["b"]]) # [1] "double"
