unravel_stage_score <- function(score_vals)
{
  stage_score = score_vals |> as.vector()
  IX_select = which(stage_score != 0)
  stage_score = stage_score[IX_select]
  return(stage_score)
}
