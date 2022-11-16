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
    forcats::fct_relevel(
      "99" ,
      "555",
      "444",
      "130",
      "200",
      "300",
      "400",
      "500",
      "600",
      "700",
      "800",
      "900",
      "777",
      "Question not asked at time of data entry; check records (777)",
      "888",
      "NA (888)",
      "999",
      "No Response (999)",
      "[Valid numeric data recorded]",
      after = Inf) |>
    forcats::fct_recode(
      "asked by clinician, but no answer from subject" = "99" ,
      "lifelong" = "555",
      "childhood" = "444",
      "teens" = "130",
      "20s" = "200",
      "30s" = "300",
      "40s" = "400",
      "50s" = "500",
      "60s" = "600",
      "70s" = "700",
      "80s" = "800",
      "90s" = "900",
      "Question not asked at time of data entry; check records (777)" = "777",
      "NA (888)" = "888",
      "No Response (999)" = "999"
    ) |>
    suppressWarnings()

}
