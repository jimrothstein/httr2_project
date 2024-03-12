## useful functions?


library(rlang)
library(testthat)

# rlang::is_named(x) # T if every element of x must have name 
# rlang:: have_name(x) # T or F, returns element-by-elment 
# rlang::has_name(x, name="joe") # T if somewhere elment named "joe"

#' f 
#'
#' @param x dataframe or named list
#' @param name name of column (if dataframe) or element name (if list) 
#'
#' @return
#' @export
#'
#' @examples
f = function(x=NULL, name=NULL){
  stopifnot(rlang::is_named(x))
  rlang::has_name(x, name)
}


z = list(
  list(a=1, 
       list(jim=2, joe=3))
)

testthat::test_that("testing rlang::has_name", {
  testthat::expect_error(f(x=3))
 testthat::expect_true(f(x=mtcars, "hp"))
 testthat::expect_true(f(x=list(joe=1),  name= "joe"))
 testthat::expect_false(f(x=list(joe=1),  name= "jim"))
 testthat::expect_true(f(x=list(joe=1, bob=2), "bob"))
 
 #testthat::expect_false(f(x=z, name="joe"))
})

#' ------------------------- 
#'  rlang::have_names  reports element-by-element (vectorized) 
#' ------------------------- 
testthat::test_that(desc="test rlang::have_names()", { 
  
  testthat::expect_no_error( {
   as.list(letters[1:5 ]) 
  })
  
  #formals(expect_false)
  #formals(expect_no_error)
  
   L = as.list(letters[1:5 ]) 
   names(L) = letters[1:5]
  
   testthat::expect_length(rlang::have_name(L),  length(L))
   
  testthat::expect_true(
    all(rlang::have_name(x=L))
  )
  
  })

##  is_named()    ALL elements must be named
is_named(x=3)
is_named(x=list(joe=1, 3))
is_named(x=list(joe=1, a=3))
is_named(x=list(joe=1, a=3, list(j=1)))
is_named(x=list(joe=1, a=3, k= list(j=1)))

f = function(df, col) {
  col = substitute(col)
  df[[col]]
}
f(mtcars, hp)
