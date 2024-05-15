`%lacks_all%` <- function(df, varnames) {
    all(!(varnames %in% names(df)))
    }


`%lacks_all%`(mtcars, c("hp", "jim"))
`%lacks_all%`(mtcars, names(mtcars))
`%lacks_all%`(mtcars, c("jim", "joe"))

