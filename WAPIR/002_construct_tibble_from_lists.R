# ---------------------------------------
#      Make a tibble from list  of lists, attributes ...
# ---------------------------------------

# --------------------------
#   Examine exising tibble, output to dput
#   Note:   row.names
# --------------------------


t <- tibble(
  a = c(1, 2),
  b = c(11, 12)
)
is_tibble(t) # [1] TRUE

dput(t)
# structure(list(a = c(1, 2), b = c(11, 12)), class = c("tbl_df",
# "tbl", "data.frame"), row.names = c(NA, -2L))
# # A tibble: 2 × 2
#       a     b
#   <dbl> <dbl>
# 1     1    11
# 2     2    12


# ------------------------------------------------
#   From dput output, re-create tibble
# ------------------------------------------------

# redo what dput told us
t1 <- structure(list(a = c(1, 2), b = c(11, 12)), class = c(
  "tbl_df",
  "tbl", "data.frame"
), row.names = c(NA, -2L))

is_tibble(t1) # [1] TRUE

identical(t, t1) # [1] TRUE

# -----------------------
# ------------
# Method 1
# build up from lists, add attributes
# ------------
t2 <- list(
  a = c(1, 2),
  b = c(11, 12)
)
is_tibble(t2) # [1] FALSE

attributes(t2) <- list(class = c("tbl_df", "tbl", "data.frame"))
is_tibble(t2) # [1] TRUE

# ---------------
# Method 2
# Use struture(
# ---------------

t3 <- structure(list(a = c(1, 2), b = c(11, 12)), class = c(
  "tbl_df",
  "tbl", "data.frame"
))

is_tibble(t3) # [1] TRUE

# ------------------------------------------------------------------
# But this way fails, need to send multiple arguments to structure?
# ------------------------------------------------------------------
L <- list(
  a = c(1, 2),
  b = c(11, 12),
  class = c("tbl_df", "tbl", "data.frame"),
  row.names = c(NA, -2L)
)
is_tibble(structure(L))
