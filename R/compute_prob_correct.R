#' Title
#'
#' @param dataset Should be just the control data?
#' @param biomarkers
#' @param DataScores
#' @param max_prob
#'
#' @return
#' @export
#'
compute_prob_correct = function(
    dataset,
    biomarkers,
    DataScores,
    max_prob = 1)
{

  # sapply(biomarkers,
  #        function(x)
  #        {
  #          min(
  #            max_prob,
  #            mean(dataset[[x]] == DataScores[[x]][1], na.rm = TRUE))
  #        })

  # prob_correct = (dataset == 0) |> colMeans() # old version
  dataset |>
    dplyr::summarize(
      across(
        .cols = all_of(biomarkers),
        .fn = ~
          mean(.x == DataScores[1], na.rm = TRUE) |>
          min(max_prob) |>
          replace_na(max_prob))
    ) |>
    unlist()
}
