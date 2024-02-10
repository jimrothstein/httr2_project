
---
title: skeleton.qmd
date: last-modified
# Quarto requires title, if want date to appear
# ~/.config/kickstart/skeleton/skeleton.qmd
---
#   TAGS:   

##  Sample constants
```{r}
channelId =  "UClB5qWyXejlAwwkDAzJis-Q" # my channel  
videoId <- "QgdVd7ujEro" # Brenda Lee
playlist_id <- "PLbcglKxZP5PMU2rNPBpYIzLTgzd5aOHw2"
```

```{r}
if (F) {
  devtools::install_github("kevin-m-kent/youtubeR")
}

library(youtubeR)
```


##  url Google Cloud 'credentials" and opens page
```{r}
(url  <- youtubeR::browse_gc_credentials())
```

##   Given playlist_id, return list of videos Ids
```{r}
#  HERE, first must manually autherize
videos  <- youtubeR::get_playlist_items(playlist_id = playlist_id)

```

vim:linebreak:nospell:nowrap:cul tw=78 fo=tqlnrc foldcolumn=1 cc=+1
