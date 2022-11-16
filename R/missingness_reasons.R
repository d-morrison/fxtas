#' Title
#'
#' @param x a numeric vector
#' @param ...
#' @inheritDotParams clean_numeric
#' @return
#' @export
#'
missingness_reasons = function(x, ...)
{
  x2 = x |> clean_numeric(...)
  b =
    if_else(
      x2 |> is.na(),
      x |> as.character(),
      "[Valid numeric data recorded]") |>
    replace_na("Field empty in RedCap")

  b = b |>
    factor(levels = b |> unique() |> sort() |> union(c(777, 888, 999))) |>
    relabel_factor_missing_codes() |>
    forcats::fct_relevel("[Valid numeric data recorded]", after = Inf)

}
