## ----setup-------------------------------------------------------------------------------------------
#| message: false
cli::cli_alert_info('\nStarting at: {Sys.time()}')

library(reticulate)
py_config()

# library(fxtas)
devtools::load_all()
library(tidyverse)
library(pander)
reticulate::use_condaenv("fxtas39", required = FALSE)
if(!reticulate::py_module_available("pySuStaIn"))
{
  stop("pySuStaIn is not installed correctly.")
}
conflicted::conflict_prefer("filter", "dplyr")

## ----------------------------------------------------------------------------------------------------
# reticulate::use_condaenv(condaenv = "fxtas")


## ----------------------------------------------------------------------------------------------------
#| label: "set run parameters"
#|
fit_models = TRUE
# fit_models = FALSE

N_startpoints = 10L
N_S_max = 1L
N_S_max_stratified = 1L
N_CV_folds = 0L
N_iterations_MCMC = 1e5L
dataset_name = 'gp34_longitudinal'
root_dir = here::here()
setwd(root_dir)
output_folder =
  "output/gp34_longitudinal" |>
  fs::dir_create()


## ----------------------------------------------------------------------------------------------------

biomarker_groups = compile_biomarker_groups_table()

SuStaInLabels =
  biomarker_varnames =
  biomarker_groups |>
  pull("biomarker")


df =
  trax_gp34_all |>
  filter(
    !is.na(`FX*`),
    # exclude patients with CGG > 200 (full mutation)
    CGG < 200)

biomarker_levels =
  lapply(df[,biomarker_varnames], F = levels)

biomarker_events_table =
  construct_biomarker_events_table(
    biomarker_levels,
    biomarker_groups)

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
    biomarker_levels = biomarker_levels)

save.image(file = fs::path(output_folder, paste0(dataset_name, ".RData")))
patient_data     |> saveRDS(file = fs::path(output_folder, "data.rds"))
biomarker_levels |> saveRDS(file = fs::path(output_folder, "biomarker_levels.rds"))
biomarker_groups |> saveRDS(file = fs::path(output_folder, "biomarker_groups.rds"))


## ----"run OSA from R"--------------------------------------------------------------------------------
#| message: false
#| label: model-all-data
#| include: false
sustain_output = run_and_save_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
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
  N_CV_folds = N_CV_folds)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: model-males
#| include: false
sustain_output_males = run_and_save_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data = patient_data |> filter(Gender == "Male"),
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "males",
  use_parallel_startpoints = FALSE,
  seed = 1,
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: model-females
#| include: false
sustain_output_females = run_and_save_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data =
    patient_data |>
    filter(Gender == "Female"),
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "females",
  use_parallel_startpoints = FALSE,
  seed = 1,
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: "cgg_over_100"
#| include: false
sustain_output_cgg100plus = run_and_save_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data = patient_data |>
    filter(`CGG` >= 100),

  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "over100",
  use_parallel_startpoints = FALSE,
  seed = 1,
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: "cgg_under_100"
#| include: false
sustain_output_cgg100minus = run_and_save_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data = patient_data |>
    filter(`CGG` < 100),

  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "under100",
  use_parallel_startpoints = FALSE,
  seed = 1,
  plot = FALSE)

