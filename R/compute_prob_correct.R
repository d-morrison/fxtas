#' Title
#'
#' @param dataset Should be just the control data?
#' @param biomarkers
#' @param DataScores
#'
#' @return
#' @export
#'
compute_prob_correct = function(dataset, biomarkers, DataScores)
{

  # prob_correct = (dataset == 0) |> colMeans() # old version
  dataset |>
    summarize(
      across(
        .cols = all_of(biomarkers),
        .fn = ~ mean(.x == DataScores[1], na.rm = TRUE))
    ) |>
    unlist()
}
