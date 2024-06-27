#' Make biomarkers table
#'
#' @param data a [data.frame()] containing the columns specified by `biomarker_varnames` as well as `"Gender"`
#' @param biomarker_varnames a [character()] vector matching a subset of the column names in `data`
#'
#' @returns a [flextable::flextable()]
#' @export
#'
#' @examples
make_biomarkers_table = function(
    data,
    biomarker_varnames)
{

  # compute p-values by gender
  pvals = numeric()

  for(cur in biomarker_varnames)
  {
    pvals[cur] =
      data |>
      mutate(
        across(
          all_of(biomarker_varnames),
          ~ .x != levels(.x)[1])) |>
      select(cur, Gender) |>
      table() |>
      fisher.test()  |>
      magrittr::use_series("p.value")

  }

  probs_above_baseline_by_gender =
    data |>
    summarize(
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
