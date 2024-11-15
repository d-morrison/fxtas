apply_cutoff = function(var, cutoff)
{
  if_else(
    var > cutoff,
    paste(">", cutoff),
    paste("≤", cutoff)
  ) |>
    factor(
      levels = c(
        paste("≤", cutoff),
        paste(">", cutoff)
      )
    )
}
