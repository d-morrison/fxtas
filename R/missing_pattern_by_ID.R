#' Title
#'
#' @param data
#' @param variable
#' @param missing_label
#'
#' @return
#' @export
#'
#' @examples
#' missing_patterns = missing_pattern_by_ID()
#' @importFrom magrittr not
missing_pattern_by_ID = function(
    data = gp34,
    variable = "ApoE",
    missing_values = c(NA, "Missing (empty in RedCap)"))
{
  data |>
    group_by(`FXS ID`) |>
    summarize(
      across(
        .cols = variable,
        .fns =
          list(
            first_missing = ~ first(.x) %in% missing_values,
            any_missing = ~ any(.x %in% missing_values),
            any_nonmissing = ~ any(magrittr::not(.x %in% missing_values)),
            n_vals = ~ .x |> setdiff(missing_values) |> length()
          ),
        .names = "{.fn}"
      )
    )
}
