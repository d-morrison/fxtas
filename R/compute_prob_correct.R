#' Compute each biomarker's probability of being recorded at its baseline level
#'
#' @param dataset a [data.frame()]; should be just control data
#' @param biomarkers a [character()] vector of biomarker variable names
#' @param biomarker_levels a list containing the levels of each biomarker
#' @param DataScores a list of possible scores
#' @param max_prob a maximum value for the baseline probability
#'
#' @return
#' @export
#'
compute_prob_correct = function(
    dataset,
    biomarker_levels,
    DataScores,
    max_prob = 1)
{

  biomarkers = names(biomarker_levels)

  prob_correct = numeric()
  for (cur_biomarker in biomarkers)
  {
    cur_baseline_level = biomarker_levels[[cur_biomarker]][1]
    prob_correct[cur_biomarker] =
      mean(
        dataset[,cur_biomarker] == cur_baseline_level,
        na.rm = TRUE) |>
      min(max_prob, na.rm = TRUE)
  }

  return(prob_correct)
}
