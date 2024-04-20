## ----setup-------------------------------------------------------------------------------------------
#| message: false
message('Starting at: ', Sys.time())

library(reticulate)
# reticulate::use_condaenv("fxtas39", required = TRUE)
py_config()

devtools::load_all()
library(tidyverse)
library(pander)

if(!reticulate::py_module_available("pySuStaIn"))
{
  stop("pySuStaIn is not installed correctly.")
}

## ----------------------------------------------------------------------------------------------------
# reticulate::use_condaenv(condaenv = "fxtas")
reticulate::py_discover_config()
reticulate::py_config()

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

# note: there are 231 records in `visit1` with CGG >= 55, but 4 have CGG >= 200
# previously `nrow(v1_usable_cases)` was 221, which was based on incorrectly filtering on a version of CGG that hadn't been backfilled.

# March 2024, main analysis now uses Trax/GP34 Visit 1 data replacing previous version using only GP34
df =
  trax_gp34_v1 |>
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

## ----------------------------------------------------------------------------------------------------
#| tbl-cap: "Biomarkers used in analysis"
#| label: "tbl-biomarker-list"
table_out =
  biomarker_events_table |>
  select(category = biomarker_group, biomarker, levels) |>
  slice_head(by = biomarker) |>
  pander()



## ----------------------------------------------------------------------------------------------------

control_data =
  df |>
  filter(`FX*` == "CGG < 55") |>
  select(all_of(biomarker_varnames))

patient_data =
  df |>
  # na.omit() |>
  filter(`FX*` == "CGG >= 55")

message("`nrow(patient_data)` = ", nrow(patient_data))

prob_correct =
  control_data |>
  compute_prob_correct(
    max_prob = .95,
    biomarker_levels = biomarker_levels)

if(length(args) == 0 || args[1] == 1)
{
  save.image(file = fs::path(output_folder, "data.RData"))
  patient_data     |> saveRDS(file = fs::path(output_folder, "data.rds"))
  biomarker_levels |> saveRDS(file = fs::path(output_folder, "biomarker_levels.rds"))
  biomarker_groups |> saveRDS(file = fs::path(output_folder, "biomarker_groups.rds"))
}



## ----"run OSA from R"--------------------------------------------------------------------------------
#| message: false
#| label: model-all-data
#| include: false
sustain_output = run_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
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
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: model-females
#| include: false
sustain_output_females = run_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data = patient_data |> filter(Gender == "Female"),

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
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data = patient_data |> filter(`CGG` >= 100),
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
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data = patient_data |> filter(`CGG` < 100),
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
sustain_output_cgg100plus_males = run_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data = patient_data |>
    filter(
      `CGG` >= 100,
      Gender == "Male"),
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
sustain_output_cgg100minus_males = run_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data = patient_data |>
    filter(
      `CGG` < 100,
      Gender == "Male"),

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
sustain_output_cgg100plus_females = run_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data = patient_data |>
    filter(
      `CGG` >= 100,
      Gender == "Female"),

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
sustain_output_cgg100minus_females = run_OSA(
  biomarker_levels = biomarker_levels,
  prob_correct = prob_correct,
  patient_data = patient_data |>
    filter(`CGG` < 100,
           Gender == "Female"),
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified,
  N_iterations_MCMC = N_iterations_MCMC,
  output_folder = output_folder,
  dataset_name = "under100_Female",
  use_parallel_startpoints = FALSE,
  plot = FALSE)

message('Ending at: ', Sys.time())
