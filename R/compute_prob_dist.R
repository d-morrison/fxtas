#' @title Computes `p(true | obs)`? for each biomarker
#' @description
#' Includes a row for NAs, which are treated as uniformly distributed over the possible true levels of the biomarker
#'
#'
#' @param ModelScores
#' @param DataScores
#' @param biomarkers
#' @param prob_correct
#' @param biomarker_levels a list containing the levels for each biomarker
#' @param do_old if `TRUE`, build an array instead of a list, the way the python code did it
#' @return
#' @export
#'
compute_prob_dist = function(
    ModelScores,
    DataScores,
    biomarkers = names(biomarker_levels),
    prob_correct,
    biomarker_levels,
    do_old = FALSE)
{

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

  if(do_old)
  {
    prob_dist_dims =
      list(
        modelscore = ModelScores,
        datascore = DataScores,
        biomarker = biomarkers)

    prob_dist = array(
      NA,
      dim = sapply(length, X = prob_dist_dims),
      dimnames = prob_dist_dims)

    for (biomarker in biomarkers)
    {
      for (datascore in DataScores)
      {
        for (modelscore in ModelScores)
        {
          if(datascore == modelscore)
          {
            prob_dist[modelscore, datascore, biomarker] = prob_correct[biomarker]
          } else
          {
            prob_dist[modelscore, datascore, biomarker] =
              (1 - prob_correct[biomarker] ) / (length(DataScores) - 1)
          }
        }
      }
    }
  }

  return(prob_dist)
}
