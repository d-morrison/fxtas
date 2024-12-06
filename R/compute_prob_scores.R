#' @title Compute probabilities of true biomarker levels
#'
#' @param dataset a [data.frame()] containing biomarker data in columns and observations in rows; column names must include all the values of `biomarker_varnames`
#' @param biomarker_varnames a [character()] vector of biomarker variable names
#' @param ModelScores a vector of true score levels (max size among all biomarkers)
#' @param prob_dist a vector of probabilities of correctly classifying a biomarker level
#' @inheritParams run_OSA
#' @inheritDotParams compute_prob_dist
#' @returns an [array]
#' @export
#'
compute_prob_scores <- function(
    dataset,
    biomarker_levels,
    biomarker_varnames = names(biomarker_levels),
    ModelScores = compute_ModelScores(biomarker_levels),
    prob_dist = compute_prob_dist(
      biomarker_levels = biomarker_levels,
      ...),
    verbose = FALSE,
    ...
)
{
  prob_score_dims =
    list(
      ID = dataset |> dplyr::pull(`FXS ID`),
      Biomarker = biomarker_varnames,
      model = ModelScores
    )

  prob_score0 = array(
    0,
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

    cur_confusion_matrix = prob_dist[[biomarker]]
    cur_observed_scores =
      dataset[[biomarker]] |>
      as.character() |>
      stringr::str_replace_na()

    prob_score0[ , biomarker, 1:ncol(cur_confusion_matrix)] =
      cur_confusion_matrix[cur_observed_scores, ]

  }

  return(prob_score0)
}
