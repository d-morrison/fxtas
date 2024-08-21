#' Report sex differences
#'
#' @param table output from [make_biomarkers_table()]
#'
#' @returns a [character()] string
#' @export
#'
report_sex_differences = function(table)
{

  table |>
    filter(`p-value` < 0.05) |>
    mutate(
      biomarker = biomarker |>
        # stringr::str_replace("MMSE total score", "MMSE total score < 26") |>
        stringr::str_replace("Head tremor", "head tremor"),

      comparison = glue::glue(
        '"{biomarker}" ',
        "({Female} of females versus {Male} of males",
        ", p-value {`p-value` |> scales::label_pvalue()()})"
      )
    ) |>
    pull(comparison) |>
    and::and()
}
