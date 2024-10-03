#' Make biomarkers table
#'
#' @param biomarker_events_table [data.frame] from [construct_biomarker_events_table()]
#' @param data a [data.frame()] containing the columns specified by `biomarker_varnames` as well as `"Gender"`
#' @param biomarker_varnames a [character] vector matching a subset of the column names in `data`
#'
#' @returns a [flextable::flextable()]
#' @export
#'
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
#' trax_gp34_v1 |> make_biomarkers_table(
#'   biomarker_events_table = biomarker_events_table,
#'   biomarker_varnames = biomarker_varnames
#'   )
#'
make_biomarkers_table = function(
    data,
    biomarker_varnames =
      compile_biomarker_groups_table() |>
      pull("biomarker"),
    biomarker_events_table
)
{

  # compute p-values by gender
  pvals = numeric()

  for(cur in biomarker_varnames)
  {
    pvals[cur] =
      data |>
      mutate(
        above_baseline = .data[[cur]] != levels(.data[[cur]])[1]) |>
      select(above_baseline, Gender) |>
      table() |>
      fisher.test()  |>
      magrittr::use_series("p.value")

  }

  probs_above_baseline_by_gender =
    data |>
    dplyr::summarize(
      .by = "Gender",
      across(
        all_of(biomarker_varnames),
        ~ mean(.x != levels(.x)[1], na.rm = TRUE)
      )
    ) |>
    pivot_longer(
      cols = -Gender,
      names_to = "biomarker",
      values_to = "Pr(above_baseline)") |>
    mutate(
      `Pr(above_baseline)` =
        `Pr(above_baseline)` |>
        scales::percent(accuracy = 0.1)) |>
    pivot_wider(
      id_cols = "biomarker",
      names_from = Gender,
      values_from = `Pr(above_baseline)`) |>
    mutate(
      "p-value" = pvals[biomarker]
    )

  table_out =
    biomarker_events_table |>
    select(
      category = biomarker_group,
      biomarker,
      levels) |>
    slice_head(by = biomarker) |>
    filter(category != "Stage") |>
    left_join(
      probs_above_baseline_by_gender,
      by = "biomarker",
      relationship = "one-to-one"
    ) |>
    mutate(
      biomarker =
        biomarker |>
        sub(
          pattern = "*",
          replacement = "",
          fixed = TRUE))

  table_out |>
    structure(class = union('biomarkers_table', class(table_out)))


}
