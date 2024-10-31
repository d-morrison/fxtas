#' Create table of demographics statistics by most-likely latent subtype
#'
#' @param patient_data a [data.frame]
#' @param subtype_and_stage_table a [data.frame]
#'
#' @returns A [gtsummary::tbl_summary]
#' @export
#' @examples
#' patient_data = test_data_v1 |> filter(CGG >= 55, CGG < 200)
#' table = test_subtype_and_stage_table
#' table_subtype_by_demographics(#'  patient_data, table)

table_subtype_by_demographics = function(
    patient_data,
    subtype_and_stage_table
)
{

  patient_data2 =
    patient_data |>
    bind_cols(subtype_and_stage_table)

  patient_data2 |>
    filter(ml_subtype != "Type 0") |>
    droplevels() |>
    dplyr::select(ml_subtype, `FX3*`, Gender, `Primary Race/Ethnicity`) |>
    gtsummary::tbl_summary(
      by = ml_subtype,
      percent = "row",
      missing = "no" # do not show missing
      # missing_text = "Missing"
    ) |>

    gtsummary::add_p(
      pvalue_fun = function(x) gtsummary::style_number(x, digits = 3),
      test.args = c(`FX3*`, `Primary Race/Ethnicity`) ~ list(simulate.p.value = TRUE)
    ) |>
    gtsummary::add_overall() |>
    gtsummary::modify_footnote(gtsummary::all_stat_cols() ~ "n (row %)")
}
