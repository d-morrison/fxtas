cli::cli_alert_info('\nStarting at: {Sys.time()}')

library(reticulate)
py_config()

library(fxtas)
library(tidyverse)
library(pander)
# reticulate::use_condaenv("fxtas39", required = TRUE)

if(!reticulate::py_module_available("pySuStaIn"))
{
  stop("pySuStaIn is not installed correctly.")
}

#| label: "set run parameters"
#|
fit_models = TRUE
# fit_models = FALSE
run_cv =  TRUE
# run_cv = FALSE

N_startpoints = 10L
N_S_max = 6L
N_CV_folds = 10L
N_iterations_MCMC = 1e5L
dataset_name = 'trax_visit1'
root_dir = here::here()
setwd(root_dir)
output_folder =
  "output/trax_visit1" |>
  fs::dir_create()

df =
  trax_visit1 |>
  dplyr::filter(
    !is.na(`FX*`),
    # exclude patients with CGG > 200 (full mutation)
    CGG < 200)


biomarker_group_list =
  df |> compile_biomarker_group_list()

biomarker_groups =
  biomarker_group_list |>
  compile_biomarker_groups_table()

SuStaInLabels =
  biomarker_varnames =
  biomarker_groups |>
  dplyr::pull("biomarker")

biomarker_levels =
  df |>
  dplyr::select(all_of(biomarker_varnames)) |>
  lapply(FUN = levels)

biomarker_events_table =
  construct_biomarker_events_table(
    biomarker_levels,
    biomarker_groups)

nlevs =
  biomarker_levels |> sapply(length)

control_data =
  df |>
  dplyr::filter(`FX*` == "CGG <55") |>
  dplyr::select(all_of(biomarker_varnames))

patient_data =
  df |>
  # na.omit() |>
  dplyr::filter(`FX*` == "CGG \u2265 55")

prob_correct =
  control_data |>
  compute_prob_correct(
    max_prob = .95,
    biomarker_levels = biomarker_levels)

args = commandArgs(trailingOnly = TRUE)
message("args = ")
print(args)

if(length(args)==0 || ((args[1] == 1)))
{
  save.image(file = fs::path(output_folder, "data.RData"))
  patient_data     |> saveRDS(file = fs::path(output_folder, "data.rds"))
  biomarker_levels |> saveRDS(file = fs::path(output_folder, "biomarker_levels.rds"))
  biomarker_groups |> saveRDS(file = fs::path(output_folder, "biomarker_groups.rds"))
}

#| message: false
#| label: model-all-data
#| include: false





if(length(args) == 0)
{

  CV_fold_nums = 1:N_CV_folds

} else
{

  CV_fold_nums = as.integer(as.character(args[1]))

}

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
  N_CV_folds = 10,
  CV_fold_nums = CV_fold_nums)
## code to prepare `trax_only_analysis` dataset goes here

# usethis::use_data(trax_only_analysis, overwrite = TRUE)
