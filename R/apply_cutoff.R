apply_cutoff <- function(var, cutoff)
{
  if_else(
    var > cutoff,
    paste(">", cutoff),
    paste("\u2264", cutoff)
  ) |>
    factor(
      levels = c(
        paste("\u2264", cutoff),
        paste(">", cutoff)
      )
    )
}
