#' @title Computes `p(true | obs)`? for each biomarker
#' @description
#' Includes a row for NAs, which are treated as uniformly distributed over the possible true levels of the biomarker
#'
#'
#' @param prob_correct the probability of correctly classifying the underlying biomarker level: p(obs = true)
#' @param biomarker_levels a list containing the levels for each biomarker
#' @returns a [list()] of confusion [matrix()] objects
#' @export
#'
compute_prob_dist <- function(
  biomarker_levels,
  prob_correct)
{

  biomarkers = names(biomarker_levels)

  confusion_matrices = list()

  for (cur_biomarker in biomarkers)
  {
    cur_levels = biomarker_levels[[cur_biomarker]]
    n_levels = length(cur_levels)
    cur_prob_correct = prob_correct[cur_biomarker]
    cur_confusion_matrix =
      matrix(
        data = (1 - cur_prob_correct)/(n_levels - 1),
        nrow = n_levels + 1,
        ncol = n_levels,
        dimnames = list(
          observed = c(cur_levels, "NA"),
          true = cur_levels))

    diag(cur_confusion_matrix) = cur_prob_correct
    cur_confusion_matrix["NA",] = 1/n_levels
    confusion_matrices[[cur_biomarker]] = cur_confusion_matrix

  }

  prob_dist = confusion_matrices

  return(prob_dist)
}
