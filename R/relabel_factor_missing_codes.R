#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
relabel_factor_missing_codes = function(x)
{
  x |>
    forcats::fct_relevel("777",
                         "Question not asked at time of data entry; check records (777)",
                         "888",
                         "NA (888)",
                         "999",
                         "No Response (999)",
                         after = Inf) |>
    forcats::fct_recode(
      "Question not asked at time of data entry; check records (777)" = "777",
      "NA (888)" = "888",
      "No Response (999)" = "999"
    ) |>
    suppressWarnings()

}
