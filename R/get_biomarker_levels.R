#' Extract levels from a set of variable names
#'
#' @param data a [data.frame()]
#' @param varnames a [character()] specifying which columns of `data` to analyze
#'
#' @returns a [list()] of [character()] vectors containing the levels of the columns in `data` specified by `varnames`
#' @export
#'
#' @examples
#' get_levels(iris, "Species")
get_levels <- function(data, varnames)
{
  data |>
    select(all_of(varnames)) |>
    lapply(F = levels)
}
