#' Title
#' @description not sure if we need this anymore
#' @param dataset a [data.frame]
#'
#' @returns a [character] [vector] of levels
#' @export
#'
compute_score_levels <- function(dataset)
{
  # unique(df[,biomarkers], na.rm = TRUE) |> as.character()
  levels =
    dataset |>
    unlist() |>
    unique(na.rm = TRUE) |>
    sort() |>
    as.character()

  if(length(levels) > 10)
  {
    warning('We found ', length(levels), " levels:")
    print(levels[1:10])
    message("...")
  }

  return(levels)
}
