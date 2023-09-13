#' Compute missingness reasons for a vector of factor variables
#'
#' @param x the original vector
#' @param x.clean the cleaned vector
#'
#' @return a vector containing the values of x corresponding to `NA`s in x.clean,
#' @export
#'
#' @importFrom forcats fct_relevel
#' @importFrom tidyr replace_na
missingness_reasons.factor = function(
    x,
    x.clean = x |> replace_missing_codes_with_NAs())
{

  to_return =
    # first change all valid values to "[Valid data recorded]"
    if_else(
      condition = x.clean |> is.na(),
      true = x |> as.character(),
      false = "[Valid data recorded]") |>
    add_labels_to_missing_codes() |>
    forcats::fct_relevel("[Valid data recorded]", after = Inf)

}

