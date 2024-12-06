apply_cutoffs <- function(
    dataset,
    cutoffs)
{
  dataset |>
    dplyr::mutate(
      across(
        all_of(names(cutoffs)),
        .fns =
          function(x) apply_cutoff(x, cutoffs[cur_column()]),
        .names = "{.col}*"
      )
    )
}
