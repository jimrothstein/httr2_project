
---
title: "`r knitr::current_input()`"
date: "`r paste('last updated', 
    format(lubridate::now(), ' %d %B %Y'))`"
output:   
  html_document:  
        code_folding: show
        toc: true 
        toc_depth: 4
        toc_float: true
  pdf_document:   
    latex_engine: xelatex  
    toc: true
    toc_depth:  4   
fontsize: 11pt   
geometry: margin=0.4in,top=0.25in   
TAGS:  regression
---
~/code/MASTER_INDEX.md
file="/home/jim/.config/nvim/templates/skeleton.R"

####	Start, Stop
```{r server}
### returns 404 - not found
###
s = httpuv::startServer("127.0.0.1", port=8080, list() ,quiet=F)
#
s <- startServer("127.0.0.1", randomPort(), list())
s <- httpuv::startServer("127.0.0.1", port=8080, list() ,quiet=F)

s$stop()

httpuv::stopServer(s)
httpuv::stopAllServers()
httpuv::listServers()


# no:  Rscript -e 'httpuv::startServer("127.0.0.1", port=8080, list() ,quiet=F)'

```


#### A very basic application
```
s <- httpuv::startServer("127.0.0.1",	8080,
       list(
         call = function(req) {
           list(
             status = 200L,
             headers = list(
               'Content-Type' = 'text/html'
             ),
             body = "Hello world!"
           )
         }
       )
     )
     
s                                      # Start 
str(s)
s$stop()
httpuv::stopServer(s)

httpuv::stopAllServers()
httpuv::listServers()

```
#### call prepares the servers response
```
s <- httpuv::startServer("127.0.0.1",	8080,
       list(
         call = function(req) {
           list(
             status = 200L,
						 req,
             headers = list(
               'Content-Type' = 'text/html',
							 'the_value' = 'secret'

             ),
             body = paste0("Hello world!")
           )
         }
       )
     )
     
     s$stop()
s
str(s)
s$stop()
httpuv::stopServer(s)

httpuv::stopAllServers()
httpuv::listServers()

```

#### call prepares the servers response
```
# req is `env`
#
# , "<br>Path requested: ", req$PATH_INFO)
begin  <- function() {
s <- httpuv::startServer("127.0.0.1",	8080,
       list(
         call = function(req) {
           list(
             status = 200L,
             headers = list(
               'Content-Type' = 'text/html',
							 'the_value' = 'secret'

             ),
						 body  = paste0("hello world", ls(req)) 
           )
         }
       )
     )
}

s  <- begin()
s
str(s)
s$stop()
httpuv::stopServer(s)

httpuv::stopAllServers()
httpuv::listServers()

```
