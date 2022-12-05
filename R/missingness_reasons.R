#' Title
#'
#' @param x the original vector to be turned into a numeric
#' @param x.clean the cleaned vector
#' @param ...
#'
#' @inheritDotParams clean_numeric
#' @return
#' @export
#'
#' @importFrom forcats fct_relevel
#' @importFrom tidyr replace_na
missingness_reasons = function(
    x,
    x.clean = x |> clean_numeric(...),
    ...)
{

  b =
    if_else(
      x.clean |> is.na(),
      x |> as.character() |> tidyr::replace_na("Field empty in RedCap"),
      "[Valid numeric data recorded]")

  b = b |>
    factor(levels = b |> unique() |> sort() |> union(c(777, 888, 999))) |>
    relabel_factor_missing_codes() |>
    forcats::fct_relevel("[Valid numeric data recorded]", after = Inf)

}
