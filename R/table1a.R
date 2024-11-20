#' [table1::table1()] with customized settings
#'
#' @param ... arguments passed to [table1::table1()]
#'
#' @returns an object of class `"table1"`
#' @export
#'
table1a <- function(...)
{
  table1::table1(
    na.is.category = FALSE,
    NA.label = "Missing",
    # overall=c(left="Total"),
    overall = NULL,
    ...
  )
}
