
# To Render
ren_pdf  <- function(file, dir) {
rmarkdown::render(
									here( dir, file), 
									output_dir="~/Downloads/print_and_delete") 
}

# ren_pdf(file, dir)

ren_github  <- function(file, dir) {
rmarkdown::render(
									here(dir, file), 
									output_format="github_document",
									output_dir="~/Downloads/print_and_delete") 
}
# ren_github(file, dir)
#
#
#



#'  @title this_is_junk()
#'  @description \code{this_is_junk} is ery important function.
this_is_junk  <- function() { T}
