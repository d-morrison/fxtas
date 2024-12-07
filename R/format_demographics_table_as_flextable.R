#' Format the demographics table as a flextable
#'
#' @param x a [gtsummary::gtsummary] object
#' @param ... not used
#'
#' @returns a [flextable::flextable]
#' @dev
format_demographics_table_as_flextable <- function(x, ...)
{
  x |>
    gtsummary::as_flex_table() |>
    # update upper header label: '' to 'M vs. F'
    shared_flextable_settings() |>
    flextable::compose(
      part = "header",
      i = 1,
      j = "p.value_2",
      value = flextable::as_paragraph("M vs. F\n(all CGG combined)")
    ) |>
    # update lower header label: 'p-value' to 'p-value*'
    # reset p-value header column to bold font
    flextable::bold(part = "header", j = 6)
}

