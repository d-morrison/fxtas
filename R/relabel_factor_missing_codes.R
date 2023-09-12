#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
relabel_factor_missing_codes = function(x)
{

  output =
    x |>
    forcats::fct_relevel(
      "99" ,
      "777",
      "Question not asked at time of data entry; check records (777)",
      "888",
      "NA (888)",
      "999",
      "No Response (999)",
      "Missing/Refused (999)",
      "[Valid numeric data recorded]",
      after = Inf) |>
    forcats::fct_recode(
      "Asked by clinician, but no answer from subject (99)" = "99" ,

      # "Question not asked at time of data entry; check records (777)" = "777",
      # "NA (888)" = "888",
      # "No Response (999)" = "999"
      # "No"   = "777",
      # "No"   = "888",
      # "No"   = "999",
      # "No"   = "Question not asked at time of data entry; check records (777)",
      # "No"   = "NA (888)",
      # "No"   = "No Response (999)",
      # "None" = "Missing/Refused (999)"

    ) |>
    forcats::fct_na_level_to_value(
      extra_levels =
        c(
          "Missing (SCID not completed)",
          "Inadequate Info",
          "777",
          "888",
          "999",
          "Question not asked at time of data entry; check records (777)",
          "NA (888)",
          "No Response (999)",
          "Missing/Refused (999)"
          )) |>
    droplevels() |>
    suppressWarnings()

}
