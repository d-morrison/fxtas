#' Compute and paste counts and proportions
#'
#' @param x a [vector]
#'
#' @returns a [character] string
#' @export
#'
#' @examples
#' x <- test_data$`Ataxia: severity*`
#' x |> counts_and_pcts()
#'
counts_and_pcts <- function(x)
{
  counts = x |> table()
  pcts = proportions(counts) * 100
  pcts_rounded = round(pcts, 1)
  to_return = glue::glue("{counts} ({pcts_rounded}%)")
  return(to_return)
}
