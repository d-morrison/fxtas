#' Make biomarkers table
#'
#' @param biomarker_events_table [data.frame] from [construct_biomarker_events_table()]
#' @param data a [data.frame()] containing the columns specified by `biomarker_varnames` as well as `stratifying_var_names`
#' @param biomarker_varnames a [character] vector matching a subset of the column names in `data`
#' @param stratifying_var_names a [character] vector specifying variables to stratify by
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
#' test_data_v1 |>
#'  dplyr::select(all_of(biomarker_varnames)) |>
#'  lapply(F = levels)
#'
#' biomarker_events_table =
#'   construct_biomarker_events_table(
#'     biomarker_levels,
#'     biomarker_groups = biomarker_groups)
#'
#' test_data_v1 |> make_biomarkers_table(
#'   biomarker_events_table = biomarker_events_table,
#'   biomarker_varnames = biomarker_varnames
#'   )
#'
make_biomarkers_table = function(
    data,
    biomarker_varnames =
      compile_biomarker_groups_table() |>
      pull("biomarker"),
    biomarker_events_table,
    stratifying_var_names = "Gender"
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
      select(all_of(c("above_baseline", stratifying_var_names))) |>
      table() |>
      fisher.test()  |>
      magrittr::use_series("p.value")

  }

  probs_above_baseline_by_gender =
    data |>
    dplyr::summarize(
      .by = all_of(stratifying_var_names),
      across(
        all_of(biomarker_varnames),
        ~ mean(.x != levels(.x)[1], na.rm = TRUE)
      )
    )

  probs_above_baseline_by_gender =
    probs_above_baseline_by_gender |>
    pivot_longer(
      cols = -all_of(c(stratifying_var_names)),
      names_to = "biomarker",
      values_to = "Pr(above_baseline)")

  probs_above_baseline_by_gender =
    probs_above_baseline_by_gender |>
    mutate(
      # probably want to apply formatting here (after pivoting)
      # rather than during the summarize step,
      # so that accuracy is applied per-column:
      `Pr(above_baseline)` =
        `Pr(above_baseline)` |>
        formattable::percent(drop0trailing = TRUE, digits = 1))

  probs_above_baseline_by_gender =
    probs_above_baseline_by_gender |>
    pivot_wider(
      id_cols = "biomarker",
      names_from = all_of(stratifying_var_names),
      values_from = all_of("Pr(above_baseline)")) |>
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
