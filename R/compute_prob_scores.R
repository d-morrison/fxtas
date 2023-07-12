#' Title
#'
#' @param dataset
#' @param biomarker_varnames
#' @param ModelScores
#' @param DataScores
#' @param prob_dist
#'
#' @return
#' @export
#'
compute_prob_scores = function(
    dataset,
    biomarker_varnames,
    ModelScores,
    DataScores,
    prob_dist
)
{
  prob_score_dims =
    list(
      ID = dataset |> pull(`FXS ID`),
      Biomarker = biomarker_varnames,
      model = ModelScores
    )

  prob_score0 = array(
    NA,
    dim = prob_score_dims |> sapply(length),
    dimnames = prob_score_dims
  )

  for (biomarker in biomarker_varnames)
  {
    for (datascore in DataScores)
    {
      for (modelscore in ModelScores)
      {
        prob_score0[
          dataset[[biomarker]] == datascore,
          biomarker,
          modelscore
        ] =
          prob_dist[modelscore, datascore, biomarker]
      }

    }
  }
  return(prob_score0)
}
