#' Title
#'
#' @param data
#' @param variable
#'
#' @return
#' @export
#'
#' @examples
#' missing_patterns = missing_pattern_by_ID()
missing_pattern_by_ID = function(data = gp34, variable = "ApoE")
{
  data |>
    group_by(`FXS ID`) |>
    summarize(
      across(
        .cols = variable,
        .fns =
          list(
            first_missing = ~ first(.x) |> is.na(),
            any_missing = ~ any(is.na(.x)),
            any_nonmissing = ~ any(!is.na(.x)),
            n_vals = ~ n_distinct(.x, na.rm = TRUE)
          ),
        .names = "{.fn}"
      )
    )
}
