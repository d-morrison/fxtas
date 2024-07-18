# args (passed in from .sbatch file)
# 1: first permutation seed (for job arrays)
# 2: permuting variable (must be a quoted column name, such as "Gender" - 1st argument to analyze_permutations.sbatch
# 3: stratifying variable (can be "") - 2nd argument to permutations.sbatch

# for example to permute by `FX3*` and stratify by `Gender`, you can run the following command on shiva:

# `sbatch permutations.sbatch "FX3*" "Gender"`

## ----setup-------------------------------------------------------------------------------------------
#| message: false
cli::cli_alert_info('\nStarting at: {Sys.time()}')

args = commandArgs(trailingOnly = TRUE)
message("args = ", args |> paste(collapse = "; "))

if(length(args) == 0)
{
  message('no arguments found')
  permutation_seeds = 1:1020
  permuting_variables = "Gender"
  stratifying_variables = NULL

} else
{

  permutation_seeds = as.integer(as.character(args[1]))
  permuting_variables = args[2]
  stratifying_variables = args[3]
  if(is.na(stratifying_variables) || stratifying_variables == "") stratifying_variables = NULL

}

cli::cli_alert_info("permuting variables: {permuting_variables}")

if(is.null(stratifying_variables))
{
  cli::cli_alert_info("no stratifying variables provided")
} else
{
  cli::cli_alert_info("stratifying variables: {stratifying_variables}")
}

library(reticulate)
if(interactive()) reticulate::use_condaenv("fxtas39", required = TRUE)
py_config()

devtools::load_all()
library(tidyverse)
library(pander)
library(dplyr)


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
N_S_max_stratified = 1L


N_iterations_MCMC = 1e5L
dataset_name = 'sample_data'
root_dir = here::here()
setwd(root_dir)
output_folder =
  "output/output.fixed_CV" |>
  fs::dir_create()


## ----------------------------------------------------------------------------------------------------

biomarker_groups = compile_biomarker_groups_table()

biomarker_varnames =
  biomarker_groups |>
  pull("biomarker")

# April 2024, main analysis now uses Trax/GP34 Visit 1 data replacing previous version using only GP34
df =
  trax_gp34_v1 |>
  filter(
    !is.na(`FX*`),
    # exclude patients with CGG > 200 (full mutation)
    CGG < 200)

biomarker_levels = df |> get_levels(biomarker_varnames)

control_data =
  df |>
  dplyr::filter(CGG <55) |>
  select(all_of(biomarker_varnames))

patient_data =
  df |>
  # na.omit() |>
  dplyr::filter(
    CGG >= 55,
    CGG < 200)

prob_correct =
  control_data |>
  compute_prob_correct(
    max_prob = .95,
    biomarker_levels = biomarker_levels)


if(is.null(stratifying_variables))
{
  strata = data.frame(all = "")
} else
{
  strata =
    patient_data |>
    dplyr::distinct(across(all_of(stratifying_variables)))

}

for (cur_stratum in 1:nrow(strata))
{

  message("starting new stratum:")

  if(is.null(stratifying_variables))
  {
    cur_data = patient_data
    cur_stratum_string = ""
  } else
  {

    print(strata[cur_stratum,])

    cur_data =
      patient_data |>
      semi_join(
        strata[cur_stratum,],
        by = stratifying_variables)

    cur_stratum_string =
      strata[cur_stratum,] |>
      sapply(F = as.character) |>
      paste(collapse = "/")
  }

  message("output folder: ")

  output_folder1 =
    fs::path(
      output_folder,
      "permutations",
      cur_stratum_string,
      permuting_variables |>
        fs::path_sanitize() |>
        paste(collapse = "-")
    ) |>
    fs::dir_create() |>
    print()

  if(length(args) == 0 || args[1] == 1)
  {
    message('saving data to ', output_folder1)
    save.image(file = fs::path(output_folder1, "data.RData"))
    cur_data         |> saveRDS(file = fs::path(output_folder1, "data.rds"))
    biomarker_levels |> saveRDS(file = fs::path(output_folder1, "biomarker_levels.rds"))
    biomarker_groups |> saveRDS(file = fs::path(output_folder1, "biomarker_groups.rds"))
  }

  run_OSA_permuted(
    biomarker_levels = biomarker_levels,
    prob_correct = prob_correct,
    permuting_variables = permuting_variables,
    patient_data = cur_data,
    permutation_seeds = permutation_seeds,
    N_startpoints = N_startpoints,
    N_S_max = 1L,
    N_iterations_MCMC = N_iterations_MCMC,
    output_folder = output_folder1,
    use_parallel_startpoints = FALSE,
    plot = FALSE)

}

cli::cli_alert_info('\nEnding at: {Sys.time()}')


