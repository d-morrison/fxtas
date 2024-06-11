#' Make biomarkers table
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
make_biomarkers_table = function(data)
{
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
        scales::percent(accuracy = 0.01)) |>
    pivot_wider(
      id_cols = "biomarker",
      names_from = Gender,
      values_from = `Pr(above_baseline)`)

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
    flextable::flextable() |>
    flextable::set_header_labels(
      values = c("Category", "Biomarker", "Levels", "Female", "Male")
    ) |>
    flextable::width(j = ~ biomarker, width = 3) |>
    flextable::width(j = ~ category + levels, width = 2) |>
    flextable::theme_booktabs() |>
    flextable::align(j = ~ biomarker + levels, align = "center", part = "all")

}
