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
missingness_reasons.numeric = function(
    x,
    x.clean = x |> clean_numeric(...),
    ...)
{
  to_return  =

    # first change all valid values to "[Valid data recorded]"
    if_else(
      condition = x.clean |> is.na(),
      true = x |> as.character(),
      false = "[Valid data recorded]") |>
    add_labels_to_missing_codes() |>
    forcats::fct_relevel("[Valid data recorded]", after = Inf)

}
