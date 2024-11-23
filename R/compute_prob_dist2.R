#' Title
#'
#' @param ModelScores todo
#' @param DataScores a list of possible scores
#' @param biomarkers todo
#' @param prob_correct todo
#'
#' @returns a [list]
#' @export
#'
compute_prob_dist2 <- function(
    ModelScores,
    DataScores,
    biomarkers,
    prob_correct)
{
  lapply(
    X = biomarkers,
    F = function(x)
    {
      compute_prob_dist0(
        levels = DataScores[[x]],
        prob_correct = prob_correct[x])
    }
  )
}

compute_prob_dist0 <- function(
    levels,
    prob_correct)
{
  nlev = length(levels)
  p1 = (1-prob_correct) / (nlev - 1)
    c(prob_correct, rep(p1, nlev - 1)) |> setNames(nm = levels)
}
