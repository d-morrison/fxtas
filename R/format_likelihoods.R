#' Title
#'
#' @param likelihoods todo
#'
#' @returns a [tibble::tbl_df]
#' @export
#'

format_likelihoods = function(likelihoods)
{
  colnames = 1:ncol(likelihoods) |>
    paste0(" subtype", if_else(1:ncol(likelihoods) == 1, "", "s"))

  likelihoods |>
    as_tibble() |>
    setNames(colnames) |>
    mutate(Iteration = dplyr::row_number()) |>
    tidyr::pivot_longer(cols = colnames)
}
