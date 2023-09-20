#' Title
#'
#' @param patient_data
#' @param subtype_and_stage_table
#'
#' @return
#' @export
#'
table_subtype_by_gender = function(
    patient_data,
    subtype_and_stage_table
    )
{

  patient_data2 =
    patient_data |>
    bind_cols(subtype_and_stage_table)

  patient_data2 |>
    filter(ml_subtype != "Type 0") |>
    table1(
      stratified_formula("Gender", "ml_subtype"),
      # render.continuous = c(.="N", .="Mean (SD)", .="Median [Min,  Max]"),
      data = _)
}
