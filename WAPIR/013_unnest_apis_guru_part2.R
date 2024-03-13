## begin with ... , from 012_unnest

all_apis_versions
## From video part 1 of 2
qq <- all_apis_versions |> unnest_longer(col = versions, indices_to = "version")

aapw <- all_apis_versions |> unnest_longer(col = versions)

# version at about t=40





aapw
identical(qq, aapw)

qq
aapw

##  not sure why
qq |> dplyr::filter(preferred == version)


qq |>
  dplyr::filter(preferred == version) |>
  select(name, versions, version)

all_apis_preferred <- qq
names(all_apis_preferred)
names(all_apis_preferred$versions[[1]])
## ~ 38'

# find rows in x, not in y
dplyr::setdiff(
  names(all_apis_preferred$versions[[7]]),
  names(all_apis_preferred$versions[[1]])
)
## and this element is
all_apis_preferred$versions[[7]][["externalDocs"]]
# $description
# [1] "API Documentation"
#
# $url
# [1] "https://www.abstractapi.com/ip-geolocation-api#docs"


## 39'
## suspect, with same names, go wider
all_apis_preferred_wide <- all_apis_preferred |> tidyr::unnest_wider(versions)

## 40'   he re-writes as chain
