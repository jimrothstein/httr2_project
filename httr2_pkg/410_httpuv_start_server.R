# R
#
#

library(httpuv)	
httpuv::listServers()

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
s     
##  open browser:   http://127.0.0.1:8080
