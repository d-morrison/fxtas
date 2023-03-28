#' Title
#'
#' @param likelihoods
#'
#' @return
#' @export
#'

format_likelihoods = function(likelihoods)
{
  likelihoods |>
    as_tibble() |>
    setNames(
      paste(1:ncol(likelihoods), "subtype(s)")
    ) |>
    mutate(Iteration = row_number())
}
