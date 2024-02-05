## ----setup-------------------------------------------------------------------------------------------
#| message: false

library(reticulate)
py_config()

library(fxtas)
library(tidyverse)
library(pander)
#reticulate::use_condaenv("fxtas39", required = FALSE)
if(!reticulate::py_module_available("pySuStaIn"))
{
  stop("pySuStaIn is not installed correctly.")
}

## ----------------------------------------------------------------------------------------------------
# reticulate::use_condaenv(condaenv = "fxtas")
py_config()

## ----------------------------------------------------------------------------------------------------
#| label: "set run parameters"
#|
fit_models = TRUE
# fit_models = FALSE
run_CV =  TRUE
# run_CV = FALSE

N_startpoints = 10L
N_S_max = 8L
N_S_max_stratified = 2L
N_CV_folds = 10L
args = commandArgs(trailingOnly = TRUE)
message("args = ", args |> paste(collapse = "; "))
if(N_CV_folds == 0)
{
  CV_fold_nums = NULL
} else if(length(args) == 0 & N_CV_folds > 0)
{

  CV_fold_nums = 1:N_CV_folds

} else
{

  CV_fold_nums = as.integer(as.character(args[1]))

}
N_iterations_MCMC = 1e5L
dataset_name = 'sample_data'
root_dir = here::here()
setwd(root_dir)
output_folder =
  "output/output.fixed_CV" |>
  fs::dir_create()


## ----------------------------------------------------------------------------------------------------

biomarker_groups = compile_biomarker_groups_table()

SuStaInLabels =
  biomarker_varnames =
  biomarker_groups |>
  pull("biomarker")


df =
  visit1 |>
  filter(
    !is.na(`FX*`),
    # exclude patients with CGG > 200 (full mutation)
    CGG < 200)

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



## ----------------------------------------------------------------------------------------------------
#| tbl-cap: "Biomarkers used in analysis"
#| label: "tbl-biomarker-list"
table_out =
  biomarker_events_table |>
  select(category = biomarker_group, biomarker, levels) |>
  slice_head(by = biomarker)

table_out |>
  pander()



## ----------------------------------------------------------------------------------------------------

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



## ----"score_vals"------------------------------------------------------------------------------------

# sapply(X = biomarker_varnames, F = function(x) 1:nlevs[x])

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

if(length(args) == 0 || args[1] == 1)
{
  save.image(file = fs::path(output_folder, "data.RData"))
}



## ----"run OSA from R"--------------------------------------------------------------------------------
#| message: false
#| label: model-all-data
#| include: false
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
  plot = FALSE,
  patient_data = patient_data,
  N_CV_folds = N_CV_folds,
  CV_fold_nums = CV_fold_nums)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: model-males
#| include: false
sustain_output_males = run_OSA(
  prob_score = prob_score0[patient_data$Gender %in% "Male",,],
  score_vals = score_vals,
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "males",
  use_parallel_startpoints = FALSE,
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: model-females
#| include: false
sustain_output_females = run_OSA(
  prob_score = prob_score0[patient_data$Gender %in% "Female",,],
  score_vals = score_vals,
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "females",
  use_parallel_startpoints = FALSE,
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: "cgg_over_100"
#| include: false
sustain_output_cgg100plus = run_OSA(
  prob_score = prob_score0[
    patient_data$`CGG` >= 100,,],
  score_vals = score_vals,
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "over100",
  use_parallel_startpoints = FALSE,
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: "cgg_under_100"
#| include: false
sustain_output_cgg100minus = run_OSA(
  prob_score = prob_score0[
    patient_data$`CGG` < 100,,],
  score_vals = score_vals,
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "under100",
  use_parallel_startpoints = FALSE,
  plot = FALSE)

## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: "cgg_over_100 & Male"
#| include: false
sustain_output_cgg100plus = run_OSA(
  prob_score = prob_score0[
    patient_data$`CGG` >= 100 & patient_data$Gender == "Male",,],
  score_vals = score_vals,
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "over100_Male",
  use_parallel_startpoints = FALSE,
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: "cgg_under_100 & Male"
#| include: false
sustain_output_cgg100minus = run_OSA(
  prob_score = prob_score0[
    patient_data$`CGG` < 100 & patient_data$Gender == "Male",,],
  score_vals = score_vals,
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "under100_Male",
  use_parallel_startpoints = FALSE,
  plot = FALSE)

## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: "cgg_over_100 & Female"
#| include: false
sustain_output_cgg100plus = run_OSA(
  prob_score = prob_score0[
    patient_data$`CGG` >= 100 & patient_data$Gender == "Female",,],
  score_vals = score_vals,
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "over100_Female",
  use_parallel_startpoints = FALSE,
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: "cgg_under_100 & Female"
#| include: false
sustain_output_cgg100minus = run_OSA(
  prob_score = prob_score0[
    patient_data$`CGG` < 100 & patient_data$Gender == "Female",,],
  score_vals = score_vals,
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "under100_Female",
  use_parallel_startpoints = FALSE,
  plot = FALSE)

