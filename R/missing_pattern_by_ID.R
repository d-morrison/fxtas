#' Title
#'
#' @param data todo
#' @param variable todo
#' @param missing_label todo
#'
#' @return todo
#' @export
#'
#' @examples
#' missing_patterns = missing_pattern_by_ID(data = test_data_v1)
#' @importFrom magrittr not
missing_pattern_by_ID <- function(
    data,
    variable = "ApoE",
    missing_values = c(NA, "Missing (empty in RedCap)"))
{
  data |>
    group_by(.data$`FXS ID`) |>
    dplyr::summarize(
      across(
        .cols = variable,
        .fns =
          list(
            first_missing = ~ first(.x) %in% missing_values,
            any_missing = ~ any(.x %in% missing_values),
            all_missing = ~ all(.x %in% missing_values),
            any_nonmissing = ~ !all(.x %in% missing_values),
            n_vals = ~ .x |> setdiff(missing_values) |> length()
          ),
        .names = "{.fn}"
      )
    )
}
