#' Title
#'
#' @param dataset
#' @param biomarkers
#' @param ModelScores
#' @param DataScores
#' @param patient_data
#' @param prob_dist
#'
#' @return
#' @export
#'
compute_prob_scores = function(
    dataset,
    biomarkers,
    ModelScores,
    DataScores,
    prob_dist,
    patient_data =
      dataset |>
      filter(`FX*` == "CGG >= 55") |>
      select(all_of(biomarkers))
)
{
  prob_score_dims =
    list(
      ID = dataset |> filter(`FX*` == "CGG >= 55") |> pull(`FXS ID`),
      Biomarker = biomarkers,
      model = ModelScores
    )

  prob_score0 = array(
    NA,
    dim = prob_score_dims |> sapply(length),
    dimnames = prob_score_dims
  )

  for (biomarker in biomarkers)
  {
    for (datascore in DataScores)
    {
      for (modelscore in ModelScores)
      {
        prob_score0[
          patient_data[[biomarker]] == datascore,
          biomarker,
          modelscore
        ] =
          prob_dist[modelscore, datascore, biomarker]
      }

    }
  }
  return(prob_score0)
}
