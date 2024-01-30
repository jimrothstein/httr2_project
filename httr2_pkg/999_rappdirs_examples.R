	
library(rappdirs)

# find cache
rappdirs::user_cache_dir("httr2")

dir(rappdirs::user_cache_dir("httr2"), recursive=T)

# log
user_log_dir()
	
