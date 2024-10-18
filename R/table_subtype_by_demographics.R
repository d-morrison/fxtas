#' Title
#'
#' @param patient_data
#' @param subtype_and_stage_table
#'
#' @returns A [gtsummary::tbl_summary]
#' @export
#'

table_subtype_by_demographics = function(
    patient_data,
    subtype_and_stage_table
)
{

  patient_data2 =
    patient_data |>
    bind_cols(subtype_and_stage_table)

  simulated_fisher <- function(data, variable, by, ...){
    data <- data[c(variable, by)]
    stats::fisher.test(
      data[[variable]], as.factor(data[[by]]), simulate.p.value = TRUE, B = 10000,
      conf.level = 0.95
    ) |>
      broom::tidy()
  }

  patient_data2 |>
    filter(ml_subtype != "Type 0") |>
    droplevels() |>
    dplyr::select(ml_subtype, CGG, `FX3*`, Gender, `Primary Race/Ethnicity`) |>
    gtsummary::tbl_summary(
      by = ml_subtype,
      percent = "column", # revert back to column percentages
      statistic = list(
        gtsummary::all_continuous() ~ "{mean} ({sd})"
      ),
      missing = "no" # do not show missing
      # missing_text = "Missing"
    ) |>

    gtsummary::add_p(
      pvalue_fun = function(x) gtsummary::style_number(x, digits = 3),
      test = list(
        `Primary Race/Ethnicity` = "simulated_fisher"
      )
    ) |>
    gtsummary::add_overall()
    # gtsummary::modify_footnote(gtsummary::all_stat_cols() ~ "n (row %)")
}
