devtools::load_all()
library(tidyverse)
library(pander)
# reticulate::virtualenv_create("fxtas")
# reticulate::use_virtualenv("fxtas")
# reticulate::conda_create("Fxtas2")
reticulate::use_condaenv(condaenv = "Fxtas2")
# reticulate::conda_install("git+https://github.com/d-morrison/pySuStaIn", envname = 'Fxtas2', pip = TRUE)
reticulate::py_config() |> print()
#| label: "set run parameters"
#|
fit_models = TRUE
# fit_models = FALSE
run_CV =  TRUE
# run_CV = FALSE

N_startpoints = 10L
N_S_max = 6L
N_S_max_stratified = 1L
N_CV_folds = 10L
N_iterations_MCMC = 1e5L
dataset_name = 'sample_data'
root_dir = here::here()
setwd(root_dir)
output_folder =
  "output/trax_gp34_males_v1" |>
  fs::dir_create()

biomarker_groups = compile_biomarker_groups_table()

SuStaInLabels =
  biomarker_varnames =
  biomarker_groups |>
  pull("biomarker")



df =
  males_gp34_trax_v1 |>
  filter(
    !is.na(`FX*`))

biomarker_levels =
  lapply(df[,biomarker_varnames], F = levels)

df = df |>
  mutate(
    across(
      all_of(biomarker_varnames),
      ~ as.integer(.x) - 1),
    Diagnosis = as.integer(`FX*` == "CGG >= 55"))

biomarker_events_table =
  construct_biomarker_events_table(
    biomarker_levels,
    biomarker_groups)

nlevs =
  biomarker_levels |> sapply(length)

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

save.image(file = fs::path(output_folder, "data.RData"))

#| message: false
#| label: model-all-data
#| include: false

args = commandArgs(trailingOnly = TRUE)
# args = 51
print(args)

if(length(args) == 0)
{

  CV_fold_nums = 1:N_CV_folds

} else
{

  CV_fold_nums = as.integer(as.character(args[1]))

}

sustain_output = run_OSA(
  prob_score = prob_score0,
  score_vals = score_vals,
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = dataset_name,
  use_parallel_startpoints = FALSE,
  seed = 1,
  plot = FALSE,
  patient_data = patient_data,
  N_CV_folds = CV_fold_nums,
  CV_fold_nums = 1)
