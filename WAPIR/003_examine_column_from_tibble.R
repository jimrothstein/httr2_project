# 003_examine_column_from_tibble.R


# --------------------------------------------------------------
#           SUBSET v EXTRACT (tibble)
#     tibbles:   SUBSET tibble vs EXTRACT
#     ocompare df$col df[["col"]],  tidyr::hoist
#
# SUBSET:  (ie columns)   t[, 2] , t[, "b"] (all same)   =>  Tibble
# EXTACT t$b, t[["b"]], (all same)   return vector
# --------------------------------------------------------------

## Subset tibble vs extract column contents
t <- tibble(
  a = c(1, 2),
  b = c(11, 12)
)
is_tibble(t) # [1] TRUE



# ---------------------------------
##  subset,   t[,] returns tibble
# ---------------------------------
identical(t[, 2], t[, "b"]) # [1] TRUE

# -----------------
# BUT ... EXTRACT
# -----------------
identical(t$b, t[["b"]]) # [1] TRUE
typeof(t$b) # [1] "double"

# ----------------------------------------
##  EXRACT may reduce to atomic, non-list
# ----------------------------------------
is.list(t[["b"]]) # [1] FALSE
typeof(t[["b"]]) # [1] "double"
