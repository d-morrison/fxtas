#' Title
#'
#' @param df
#' @param biomarker_varnames
#' @param biomarker_levels
#' @param nlevs
#'
#' @return
#' @export
#'
model_dists = function(
    df,
    biomarker_varnames = attr(df, "biomarker_varnames"),
    biomarker_levels =
      lapply(df[,biomarker_varnames], F = levels),
    nlevs =
      biomarker_levels |> sapply(length)
)
{
  df = df |>
    mutate(
      across(
        all_of(biomarker_varnames),
        ~ as.integer(.x) - 1),
      Diagnosis = as.integer(`FX*` == "CGG >= 55"))

  ModelScores = DataScores =
    df |>
    select(all_of(biomarker_varnames)) |>
    # lapply(F = levels)
    compute_score_levels()


  control_data =
    df |>
    filter(`FX*` == "CGG < 55") |>
    select(all_of(biomarker_varnames))

  patient_data =
    df |>
    # na.omit() |>
    filter(`FX*` == "CGG >= 55")

  prob_correct =
    control_data |>
    compute_prob_correct(
      max_prob = .95,
      biomarkers = biomarker_varnames,
      DataScores = DataScores)

  prob_score0 = compute_prob_scores(
    dataset = patient_data,
    biomarker_varnames,
    ModelScores = ModelScores,
    DataScores = DataScores,
    prob_correct = prob_correct
  )

  prob_nl = prob_score0[,,1]
  prob_score = prob_score0[,,-1, drop = FALSE]

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
