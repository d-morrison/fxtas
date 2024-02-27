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
    prob_dist = compute_prob_dist(
      ModelScores = ModelScores,
      DataScores = DataScores,
      biomarkers = biomarker_varnames,
      ...
    ),
    verbose = FALSE,
    ...
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

  if(verbose)
  {
    message("dim(prob_score0) = ")
    print(dim(prob_score0))
  }

  for (biomarker in biomarker_varnames)
  {

    if(verbose) message('computing prob scores for ', biomarker, " at ", Sys.time())
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

    if (any(dataset[[biomarker]] |> is.na()))
    {
      prob_score0[
        dataset[[biomarker]] |> is.na(),
        biomarker,

      ] = 1/length(ModelScores)
    }

  }
  return(prob_score0)
}
