#' Title
#'
#' @param patient_data
#' @param subtype_and_stage_table
#'
#' @return
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

  patient_data2 |>
    filter(ml_subtype != "Type 0") |>
    tableby(
      ml_subtype ~ Gender + `Primary Race` + `Primary Ethnicity`,
      cat.stats="countrowpct",
      data = _) |>
    summary(pfootnote=TRUE)
}
