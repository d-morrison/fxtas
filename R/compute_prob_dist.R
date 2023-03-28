#' Title
#'
#' @param ModelScores
#' @param DataScores
#' @param biomarkers
#' @param prob_correct
#'
#' @return
#' @export
#'
compute_prob_dist = function(
    ModelScores,
    DataScores,
    biomarkers,
    prob_correct)
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

  return(prob_dist)
}
