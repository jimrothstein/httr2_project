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

# R
#
#

library(httpuv)	
httpuv::listServers()
s = httpuv::startServer("127.0.0.1", port=8080, list() ,quiet=F)
httpuv::stopAllServers()

     # A very basic application
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
       ) # end outer list
     )
     
##  open browser:   http://127.0.0.1:8080



s
str(s)
s$stop()
httpuv::stopServer(s)
httpuv::stopAllServers()
httpuv::listServers()
