#' Build a formula for [table1::table1()]
#'
#' @param vars row variables
#' @param strata column variables
#'
#' @returns a [formula()] object
#' @export
#'
#' @examples
#' stratified_formula(c("Sepal.Length" ,"Sepal.Width"), "Species")
stratified_formula <- function(vars, strata)
{
  paste(
    "~",
    vars |> collapse_vars(),
    "|",
    strata |> collapse_vars()
  ) |>
    formula()
}
