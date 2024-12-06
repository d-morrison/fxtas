#' Title
#'
#' @param dataset Should be just the control data?
#' @param biomarkers todo
#' @param DataScores a list of possible scores
#' @param max_prob [numeric] between 0 and 1 specifying the probability
#'
#' @returns a [numeric] [vector]
#' @export
#'
compute_prob_correct2 <- function(
    dataset,
    biomarkers,
    DataScores,
    max_prob = 1)
{

  biomarkers |>
    sapply(
      function(x)
      {
        mean(dataset[[x]] == DataScores[[x]][1], na.rm = TRUE)
      }) |>
    pmin(max_prob)

  # prob_correct = (dataset == 0) |> colMeans() # old version
  # dataset |>
  #   summarize(
  #     across(
  #       .cols = all_of(biomarkers),
  #       .fns = ~ min(
  #         max_prob,
  #         mean(.x == DataScores[1], na.rm = TRUE)))
  #   ) |>
  #   unlist()
}
