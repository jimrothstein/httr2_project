# REF: https://tidyr.tidyverse.org/articles/rectangle.html

library(tidyr)
library(dplyr)
library(repurrrsive)

users <- tibble(user = gh_users)

dim(users) # [1] 6 1
head(users, n = 2)
# # A tibble: 2 × 1
#   user
#   <list>
# 1 <named list [30]>
# 2 <named list [30]>


# vs
# ------------------------------------
users1 <- tibble::enframe(gh_users)
# ------------------------------------
# # A tibble: 6 × 2
#    name value
#   <int> <list>
# 1     1 <named list [30]>
# 2     2 <named list [30]>
# 3     3 <named list [30]>
# 4     4 <named list [30]>
# 5     5 <named list [30]>
# 6     6 <named list [30]>


# -------------------------------------
#       examine names, from first row
# -------------------------------------
names(users1$value[[1]])
sapply(users1$value, function(e) 
users1$value[1]
