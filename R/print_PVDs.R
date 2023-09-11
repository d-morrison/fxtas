#' Title
#'
#' @param figs
#'
#' @return
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

}
