#' Title
#' @description possibly not needed; keeping because it has an example of using attributes that I want to propagate across the codebase
#' @param df todo
#' @param biomarker_varnames todo
#' @param biomarker_levels todo
#' @param nlevs todo
#'
#' @inherit build_score_vals return
#' @export
#'
model_dists <- function(
    df,
    biomarker_varnames = attr(df, "biomarker_varnames"),
    biomarker_levels =
      lapply(df[,biomarker_varnames], FUN = levels),
    nlevs =
      biomarker_levels |> sapply(length)
)
{
  score_vals = build_score_vals(biomarker_levels)

  return(score_vals)
}
