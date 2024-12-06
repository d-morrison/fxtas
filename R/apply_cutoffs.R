apply_cutoffs <- function(
    dataset,
    cutoffs)
{
  dataset |>
    dplyr::mutate(
      across(
        all_of(names(cutoffs)),
        .fns =
          ~ apply_cutoff(.x, cutoffs[cur_column()]),
        .names = "{.col}*"
      )
    )
}
