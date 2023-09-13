#' Title
#'
#' @param x a numeric vector
#' @param NA_codes numeric values that should be turned into to NAs
#' @param extra_codes codes besides 777, 888, 999 to turn into NAs
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
}
