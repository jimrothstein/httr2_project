library(utils)

TAGS:   encode, decode URLs

URL = "https:://example.org"
URLencode(URL)



URLdecode("https://github.com/search?q=owner%3Ajimrothstein+vctrs&type=code")
# "https://github.com/search?q=owner:jimrothstein+vctrs&type=code"

URL_encode("https://github.com/search?q=owner:jimrothstein+vctrs&type=code"
