#' Title
#'
#' @param dataset Should be just the control data?
#' @param biomarkers
#' @param biomarker_levels a list containing the levels of each biomarker
#' @param DataScores
#' @param max_prob
#'
#' @return
#' @export
#'
compute_prob_correct = function(
    dataset,
    biomarkers = names(biomarker_levels),
    biomarker_levels,
    DataScores,
    max_prob = 1)
{

  prob_correct = numeric()
  for (cur_biomarker in biomarkers)
  {
    cur_baseline_level = biomarker_levels[[cur_biomarker]][1]
    prob_correct[cur_biomarker] =
      mean(dataset[,cur_biomarker] == cur_baseline_level, na.rm = TRUE) |>
      min(max_prob, na.rm = TRUE)
  }
  # sapply(biomarkers,
  #        function(x)
  #        {
  #          min(
  #            max_prob,
  #            mean(dataset[[x]] == DataScores[[x]][1], na.rm = TRUE))
  #        })

  # prob_correct = (dataset == 0) |> colMeans() # old version

  # dataset |>
  #   dplyr::summarize(
  #     across(
  #       .cols = all_of(biomarkers),
  #       .fn = ~
  #         mean(.x == DataScores[1], na.rm = TRUE) |>
  #         min(max_prob) |>
  #         replace_na(max_prob))
  #   ) |>
  #   unlist()
  return(prob_correct)
}
