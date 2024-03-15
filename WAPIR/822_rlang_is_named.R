library(rlang)

##  PURPOSE:   Tools for nested lists & names

?is_named
# is_named() is a scalar predicate about the whole vector of names:
is_named(c(a = 1, b = 2))
is_named(c(a = 1, 2))

# Unlike is_named2(), is_named() returns `FALSE` for empty vectors
# that don't have a `names` attribute.
is_named(list())
is_named2(list())

# have_name() is a vectorised predicate
have_name(c(a = 1, b = 2))
have_name(c(a = 1, 2))

# Empty and missing names are treated as invalid:
invalid <- set_names(letters[1:5])
names(invalid)[1] <- ""
names(invalid)[3] <- NA

is_named(invalid)
have_name(invalid)

# A data frame normally has valid, unique names
is_named(mtcars)
have_name(mtcars)

# A matrix usually doesn't because the names are stored in a
# different attribute (NO names attribute)
mat <- matrix(1:4, 2)
colnames(mat) <- c("a", "b")
is_named(mat)
names(mat)

###

t <- tibble(
  a = 1:5,
  b = list(letters[1:5])
)
is_named(t)
attributes(t)

is_named(t$a)
is_named(t$b)
t$b[[1]]

##  TODO: when does attributes appear?  when is_named T/F
L <- list(a = 1, b = 2)
K <- list(1, 2, z = list(a = 1, b = 2))
K1 <- list(1, 2, z = list(a = 1, b = 2, q = list(c = 1, 2)))
M <- list(a = 1, b = 2, z = list(1, 2))
sapply(list(L, K, K1, M), rlang::is_named)
sapply(list(L, K, K1, M), rlang::have_name) # vector version
