#' Title
#'
#' @param vars
#' @param stratum
#'
#' @return
#' @export
#'
#' @examples
#' stratified_formula(c("Sepal.Length" ,"Sepal.Width"), "Species")
stratified_formula = function(vars, stratum)
{
  paste(
    "~",
    paste(formulaic::add.backtick(vars), collapse = " + "),
    "|",
    formulaic::add.backtick(stratum)
  ) |>
    formula()
}
