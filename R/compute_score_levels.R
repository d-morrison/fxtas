#' Title
#'
#' @param dataset
#'
#' @return
#' @export
#'
compute_score_levels = function(dataset)
{
  # unique(df[,biomarkers], na.rm = TRUE) |> as.character()
  dataset |>
    unlist() |>
    unique(na.rm = TRUE) |>
    sort() |>
    as.character()
}
