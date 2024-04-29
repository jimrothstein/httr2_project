160_httr2_albert_rapp.R

        library(httr2)
        library(jsonlite)
        library(data.table)

        base_url <- "https://www.googleapis.com/youtube/v3/playlists"
        auth_url <- "https://accounts.google.com/o/oauth2/v2/auth"
        token_url <- "https://oauth2.googleapis.com/token"

        ##  Retrieve from ~/.Renviron
        API_KEY <- Sys.getenv("API_KEY")
        client_id <- Sys.getenv("YOUTUBE_CLIENT_ID")
        client_secret <- Sys.getenv("YOUTUBE_CLIENT_SECRET")


        ##  Google wants muliple scopes separated by white space.
        scope <- paste0(
                "https://www.googleapis.com/auth/youtube.force-ssl ",
                "https://www.googleapis.com/auth/youtube"
        )
        # try this (single) scope
        scope <- "https://www.googleapis.com/auth/youtube.force-ssl "
