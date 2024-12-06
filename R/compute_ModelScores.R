compute_ModelScores <- function(biomarker_levels)
{
  max_levels = biomarker_levels |> sapply(FUN = length) |> max()
  ModelScores = (1:max_levels) - 1
}
