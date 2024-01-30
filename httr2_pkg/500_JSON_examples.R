library(jsonlite)
library(data.table)


####  flatten = T,  easy conversion nested JSON to R table {
mydata <- fromJSON("https://projects.propublica.org/forensics/geos.json", flatten = TRUE)
View(mydata)


dt  <- as.data.table(mydata)
str(dt )
}


#### multi-page data, convert to R-object (list)
{
baseurl <- "https://projects.propublica.org/nonprofits/api/v2/search.json?order=revenue&sort_order=desc"
mydata0 <- fromJSON(paste0(baseurl, "&page=0"), flatten = TRUE)
mydata1 <- fromJSON(paste0(baseurl, "&page=1"), flatten = TRUE)
mydata2 <- fromJSON(paste0(baseurl, "&page=2"), flatten = TRUE)


	#	each is list of 12 elements
	str(mydata0)

	#The actual data is in the organizations element
	nrow(mydata0$organizations) #100
	mydata0$organizations[1:10, c("name", "city", "strein")]

}


#### rbind data element of each page 
{
#Combine data frames
organizations <- rbind_pages(
  list(mydata0$organizations, mydata1$organizations, mydata2$organizations)
)

#Total number of rows
nrow(organizations)
}


#### loop to collect ALL pages (easier to follow vs lapply)
{
#store all pages in a list first
baseurl <- "https://projects.propublica.org/nonprofits/api/v2/search.json?order=revenue&sort_order=desc"
pages <- list()
for(i in 0:20){
  mydata <- fromJSON(paste0(baseurl, "&page=", i))
  message("Retrieving page ", i)
  pages[[i+1]] <- mydata$organizations
	length(pages)
}

#### Last step:  combine all pages
	{
		organizations  <- rbind_pages(pages)
		nrow(organizations)

}
