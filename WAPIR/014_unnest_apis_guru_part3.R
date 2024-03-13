## about 40'   (Jon re-writes as chain)
t40 <- all_apis_versions |> unnest_wider(versions)


##  info - wider?longer?

lengths(t40$info)
lengths(t40$info) |> unique()


setdiff(
  names(t40$info[[1]]),
  names(t40$info[[2]])
)
setdiff(
  names(t40$info[[2]]),
  names(t40$info[[1]])
)

rlang::is_named(t40$info)
# [1] FALSE


## hoist
t40 |> tidyr::hoist(info, categories = "x-apisguru-categories")
t40 |>
  tidyr::hoist(info, categories = "x-apisguru-categories") |>
  rowwise()

t43 <-
  t40 |>
  tidyr::hoist(info, categories = "x-apisguru-categories") |>
  rowwise() |>
  dplyr::filter("open_data" %in% categories) |>
  ungroup()

## could  do
t43 |> unnest_longer(categories)

t43$categories[[1]]

t40 |>
  tidyr::hoist(info, categories = "x-apisguru-categories") |>
  rowwise() |>
  select(categories)
