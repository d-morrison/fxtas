#' Clean a Numeric Variable
#'
#' Replace missing codes (e.g., 777, 888, 999) with NAs in a numeric variable
#' @param x a numeric vector
#' @param NA_codes numeric values that should be turned into to NAs
#' @param extra_codes codes besides 777, 888, 999 to turn into NAs; has no effect if the `NA_codes` argument is changed from default by the user.
#'
#' @return
#' @export
#'
clean_numeric = function(
    x,
    NA_codes = c(777, 888, 999, extra_codes),
    extra_codes = NULL)
{

  if_else(
    condition = x %in% NA_codes,
    true = NA_real_,
    false = x |> as.numeric() |> suppressWarnings())

## equivalent(?):
# x |> as.numeric() |> suppressWarnings() |>
#   case_match(NA_codes ~ NA_real_, .default = x)
## implementations with `replace()` are also possible, and maybe faster: https://stackoverflow.com/a/27909037/9286327
## `na_if()` can't replace multiple values: https://github.com/tidyverse/dplyr/issues/1972
}
