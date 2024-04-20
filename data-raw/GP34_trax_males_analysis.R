# devtools::load_all()
print(R.version)
message('working directory = ')
print(getwd())
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
# pySuStaIn = reticulate::import("pySuStaIn", delay_load = TRUE)
# pySuStaIn = reticulate::import_from_path("pySuStaIn", path = "~/.virtualenvs/r-pySuStaIn/lib/python3.11/site-packages/")
# pySuStaIn
# fun1 = pySuStaIn$OrdinalSustain
# reticulate::use_condaenv(condaenv = "fxtas")

# reticulate::use_virtualenv("r-pySuStaIn")

#| label: "set run parameters"
#|
fit_models = TRUE
# fit_models = FALSE
run_CV =  TRUE
run_CV = FALSE

N_startpoints = 10L
N_S_max = 2L
N_CV_folds = 0L
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
    !is.na(`FX*`),
    CGG < 200
    # exclude patients with CGG > 200 (full mutation)
    )

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

args = commandArgs(trailingOnly = TRUE)
print(args)

if(length(args)==0 || (length(args) > 0 && (args[1] == 1)))
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
  seed = 1,
  plot = FALSE,
  patient_data = patient_data,
  N_CV_folds = N_CV_folds,
  CV_fold_nums = CV_fold_nums)
