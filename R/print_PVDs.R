#' Print a list of PVDs
#'
#' @param figs a [list] of [ggplot2::ggplot] objects
#'
#' @returns `figs`, invisibly
#' @export
#'
print_PVDs = function(figs)
{

  print(figs[[1]])

  if(length(figs) > 1)
  {
    for (i in 2:length(figs))
    {
      {
        figs[[i]] #  + scale_y_discrete(breaks = NULL, limits = rev)
      } |>
        suppressMessages() |>
        print()
    }
  }

  return(invisible(figs))

}
