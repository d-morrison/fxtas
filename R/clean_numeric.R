#' Title
#'
#' @param x a numeric vector
#' @param NA_codes numeric values that should be turned into to NAs
#'
#' @return
#' @export
#'
clean_numeric = function(x, NA_codes = c(777, 888, 999))
{

  if_else(
    x %in% NA_codes,
    NA_real_,
    x |> as.numeric() |> suppressWarnings())
}
