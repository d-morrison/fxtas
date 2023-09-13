#' Replace missing codes with NAs
#'
#' @param x a factor or character vector
#'
#' @return a factor vector similar to `x`, but with 99, 777, 888, 999, etc replaced with `NA`s
#' @export
#'
replace_missing_codes_with_NAs = function(x)
{
  x |>
    forcats::fct_na_level_to_value(
      extra_levels =
        c(
          "NA",
          "Missing (SCID not completed)",
          "Inadequate Info",
          "99",
          "777",
          "888",
          "999",
          "Asked by clinician, but no answer from subject (99)",
          "Question not asked at time of data entry; check records (777)",
          "NA (888)",
          "No Response (999)",
          "Missing/Refused (999)",
          "Missing (empty in RedCap)"
        )) |>
    suppressWarnings()
}
