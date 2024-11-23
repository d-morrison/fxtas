get_colour_mat <- function(
    cmap,
    N_z
)
{
  if(cmap == "original")
  {
    # Hard-coded colours: hooray!
    colour_mat = rbind(
      c(1, 0, 0),
      c(1, 0, 1),
      c(0, 0, 1),
      c(0.5, 0, 1),
      c(0, 1, 1),
      c(0, 1, 0.5)) |>
      head(N_z)

    # We only have up to 5 default colours, so double-check
    if (nrow(colour_mat) < N_z)
    {
      stop(paste("Colours are only defined for", nrow(colour_mat), " z-scores!"))
    }
  } else
  {
    stop()
  }
  return(colour_mat)
}
