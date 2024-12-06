## ----setup-------------------------------------------------------------------------------------------
#| message: false
cli::cli_alert_info('\nStarting at: {Sys.time()}')

library(reticulate)
reticulate::use_condaenv("fxtas39", required = TRUE)
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
run_cv =  TRUE
# run_cv = FALSE

N_startpoints = 10L
use_parallel_startpoints = TRUE
use_parallel_startpoints = FALSE
N_S_max = 3L
N_S_max_stratified = 2L
N_CV_folds = 10L
rerun = TRUE
# rerun = FALSE
plot_python = TRUE
fig_size = c(20, 10)

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
  "output/test_data" |>
  fs::dir_create()


## ----------------------------------------------------------------------------------------------------

biomarker_groups =
  compile_biomarker_groups_table(dataset = test_data_v1)

library(dplyr)
biomarker_groups = biomarker_groups |>
  dplyr::filter(biomarker_group %in% c("Tremors", "Stage", "Ataxia", "Parkinsonian", "MRI"))

SuStaInLabels =
  biomarker_varnames =
  biomarker_groups |>
  dplyr::pull("biomarker")

# note: there are 231 records in `visit1` with CGG >= 55, but 4 have CGG >= 200
# previously `nrow(v1_usable_cases)` was 221, which was based on incorrectly filtering on a version of CGG that hadn't been backfilled.

# March 2024, main analysis now uses Trax/GP34 Visit 1 data replacing previous version using only GP34
df =
  test_data_v1 |>
  dplyr::filter(
    !is.na(`FX*`),
    # exclude patients with CGG > 200 (full mutation)
    CGG < 200)


biomarker_levels =
  lapply(df[,biomarker_varnames], F = levels)

biomarker_events_table =
  construct_biomarker_events_table(
    biomarker_levels,
    biomarker_groups)

cli::cli_inform("Biomarkers used in analysis:")
table_out =
  biomarker_events_table |>
  dplyr::select(category = biomarker_group, biomarker, levels) |>
  slice_head(by = biomarker) |>
  pander()



## ----------------------------------------------------------------------------------------------------

control_data =
  df |>
  dplyr::filter(`FX*` == "CGG <55") |>
  dplyr::select(all_of(biomarker_varnames))

patient_data =
  df |>
  # na.omit() |>
  dplyr::filter(`FX*` == "CGG \u2265 55")

cli::cli_inform("`nrow(patient_data)` = {nrow(patient_data)}")

prob_correct =
  control_data |>
  compute_prob_correct(
    max_prob = .95,
    biomarker_levels = biomarker_levels)

if(length(args) == 0 || args[1] == 1)
{
  cli::cli_inform("saving data")
  patient_data     |> readr::write_rds(file = fs::path(output_folder, "data.rds"))
  biomarker_levels |> readr::write_rds(file = fs::path(output_folder, "biomarker_levels.rds"))
  biomarker_groups |> readr::write_rds(file = fs::path(output_folder, "biomarker_groups.rds"))
}

cli::cli_inform('about to start')

## ----"run OSA from R"-------------------------------------------------------------------------------
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
  use_parallel_startpoints = use_parallel_startpoints,
  plot = plot_python,
  fig_size = fig_size,
  rerun = rerun,
  patient_data = patient_data,
  N_CV_folds = N_CV_folds,
  CV_fold_nums = CV_fold_nums)
