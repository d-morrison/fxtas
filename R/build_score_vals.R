#' Construct the table indicating how many levels each biomarker has
#'
#' @inheritParams compute_prob_dist
#'
#' @returns a [matrix()] indicating which levels each biomarker has
#' @export
#'
build_score_vals <- function(
    biomarker_levels
)
{
  nlevs = biomarker_levels |> sapply(length)
  max_levels = nlevs |> max()
  ModelScores = (1:max_levels) - 1
  biomarker_varnames = names(biomarker_levels)

  score_vals = matrix(
    ModelScores[-1] |> as.numeric(),
    byrow = TRUE,
    nrow = length(biomarker_varnames),
    ncol = length(ModelScores) - 1,
    dimnames = list(biomarker_varnames, ModelScores[-1]))

  for (i in biomarker_varnames)
  {
    score_vals[i,score_vals[i,] > nlevs[i]-1] = 0
  }

  return(score_vals)
}
