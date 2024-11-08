#' Format the demographics table as a flextable
#'
#' @param x a [gtsummary::gtsummary] object
#' @param ... not used
#'
#' @returns a [flextable::flextable]
#' @dev
#' test_data_v1 |> make_demographics_table() |>
#' format_demographics_table_as_flextable()
format_demographics_table_as_flextable = function(x, ...)
{
  x |>
    gtsummary::as_flex_table() |>
    # update upper header label: '' to 'M vs. F'
    flextable::compose(
      part = "header",
      i = 1,
      j = "p.value_2",
      value = flextable::as_paragraph("M vs. F (all CGG combined)")
    ) |>
    # update lower header label: 'p-value' to 'p-value*'
    flextable::compose(
      part = "header",
      i = 2,
      j = "p.value_2",
      value = flextable::as_paragraph("p-value", flextable::as_sup("*"))
    ) |>
    # reset p-value header column to bold font
    flextable::bold(part = "header", j = 6)
}

