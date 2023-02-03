#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
numeric_as_factor = function(x)
{

  x |>
    factor(levels = x |> unique() |> sort()) |>
    relabel_factor_missing_codes()

}
