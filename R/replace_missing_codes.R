#' Replace missing codes in a vector of factor variables
#'
#' The default is to use the reference level of the factor.
#'
#' @param x a [factor] vector
#' @param missing_codes a vector of strings
#' @param replacement a string variable or `NA`
#' @param mapping a named string vector
#'
#' @returns a [factor] vector
#' @export
#'
#' @examples
#' x = iris$Species |> unique()
#' x |> replace_missing_codes(missing_codes = "virginica", replacement = "versicolor")
replace_missing_codes = function(
    x,
    missing_codes = c(
      "99",
      "777",
      "888",
      "999",
      "Asked by clinician, but no answer from subject (99)",
      "Question not asked at time of data entry; check records (777)",
      "NA (888)",
      "No Response (999)",
      "Missing/Refused (999)"),
    replacement = levels(x)[1],
    mapping =
      rep(replacement, length(missing_codes)) |>
      setNames(missing_codes))
{

  stopifnot(length(replacement) == 1)
  # don't want to deal with more complex mappings right now

  levels_to_replace = levels(x) %in% names(mapping)
  replacements = mapping[levels(x)[levels_to_replace]]
  levels(x)[levels_to_replace] = replacements

  return(x)
}
