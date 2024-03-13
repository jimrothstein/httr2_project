library(dplyr)

## SAMPLE
z <- structure(list(Year = c(2019L, 2019L, 2019L, 2019L), Location = c(
  "Tela",
  "Tela", "Tela", "Tela"
), Site = c("AD", "AD", "AD", "AD"), Depth = c(
  10L,
  10L, 10L, 10L
), Transect = 1:4, ID = c(
  "2019_Tela_AD_1_10", "2019_Tela_AD_2_10",
  "2019_Tela_AD_3_10", "2019_Tela_AD_4_10"
), `Stegastes planifrons` = list(
  "1", NULL, NULL, c(
    "10", "10", "10", "10", "10", "10", "10",
    "10", "10", "10"
  )
), `Anisotremus virginicus` = list(c(
  "4",
  "4", "4", "4"
), "1", NULL, NULL), `Stegastes adustus` = list(
  c("9", "9", "9", "9", "9", "9", "9", "9", "9"), c(
    "10", "10",
    "10", "10", "10", "10", "10", "10", "10", "10"
  ), c(
    "15",
    "15", "15", "15", "15", "15", "15", "15", "15", "15", "15",
    "15", "15", "15", "15"
  ), c(
    "14", "14", "14", "14", "14",
    "14", "14", "14", "14", "14", "14", "14", "14", "14"
  )
), `Stegastes partitus` = list(
  c("9", "9", "9", "9", "9", "9", "9", "9", "9"), "1", c(
    "14",
    "14", "14", "14", "14", "14", "14", "14", "14", "14", "14",
    "14", "14", "14"
  ), c(
    "10", "10", "10", "10", "10", "10",
    "10", "10", "10", "10"
  )
)), row.names = c(NA, -4L), class = c(
  "tbl_df",
  "tbl", "data.frame"
))


str(z)
str(z, max.level = 3)
library(purrr)
library(dplyr)
df <- z
list_df <- df %>%
  dplyr::select(
    `Stegastes planifrons`, `Anisotremus virginicus`, `Stegastes adustus`,
    `Stegastes partitus`
  ) %>%
  purrr::map_depth(., 2, ~ ifelse(is.null(.x), 0, .x)) %>%
  purrr::map_df(unlist) %>%
  dplyr::mutate_if(is.character, as.numeric)

df %>%
  select(Year:ID) %>%
  cbind(list_df)
