#' Report sex differences
#'
#' @param table output from [make_biomarkers_table()]
#'
#' @returns a [character()] string
#' @export
#' @examples
#' biomarker_groups = compile_biomarker_groups_table()
#'
#' biomarker_varnames =
#'   biomarker_groups |>
#'   pull("biomarker")
#'
#' biomarker_levels =
#' trax_gp34_v1 |>
#'  dplyr::select(all_of(biomarker_varnames)) |>
#'  lapply(F = levels)
#'
#' biomarker_events_table =
#'   construct_biomarker_events_table(
#'     biomarker_levels,
#'     biomarker_groups = biomarker_groups)
#'
#' table = trax_gp34_v1 |> make_biomarkers_table(
#'   biomarker_events_table = biomarker_events_table,
#'   biomarker_varnames = biomarker_varnames
#'   )
#'
#'   table |> report_sex_differences()
#'
report_sex_differences = function(table)
{

  table |>
    filter(`p-value` < 0.05) |>
    mutate(
      biomarker = biomarker |>
        stringr::str_replace(
          "Increased tone",
          "increased tone"
        ) |>
        stringr::str_replace(
          "MMSE total score",
          "Mini-Mental State Examination (MMSE) total score < 21 (mild impairment or worse)"
        ) |>

        stringr::str_replace(
          "SWM Between errors",
          "the CANTAB subtest of Spatial Working Memory (SWM) Between errors") |>
        # stringr::str_replace("MMSE total score", "MMSE total score < 26") |>
        stringr::str_replace("Head tremor", "head tremor"),

      p_val_formatted =
        `p-value` |>
        scales::label_pvalue(
          prefix = paste(c('<', '=', '>'), ''))(),

      comparison = glue::glue(
        '"{biomarker}" ',
        "({Female} of females versus {Male} of males",
        ", p-value {p_val_formatted}"

      )
    ) |>
    pull(comparison) |>
    and::and()
}
