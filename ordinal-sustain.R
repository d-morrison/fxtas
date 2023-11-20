## ----include = FALSE---------------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  # fig.width = 7, 
  # fig.height = 10,
  include = TRUE
)


## ----setup-------------------------------------------------------------------------------------------
#| message: false
devtools::load_all()
library(tidyverse)
library(reticulate)
library(pander)


## ----------------------------------------------------------------------------------------------------
# reticulate::use_condaenv(condaenv = "fxtas")


## ----------------------------------------------------------------------------------------------------
#| label: "set run parameters"
#|
fit_models = TRUE
# fit_models = FALSE
run_CV =  TRUE
# run_CV = FALSE

N_startpoints = 10L
N_S_max = 5L
N_S_max_stratified = 1L
N_CV_folds = 10L
N_iterations_MCMC = 1e5L
dataset_name = 'sample_data'
root_dir = here::here()
setwd(root_dir)
output_folder = 
  "output/output.longest" |> 
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

save.image(file = fs::path(output_folder, "data.RData"))



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
  seed = 1,
  plot = FALSE,
  patient_data = patient_data,
  N_CV_folds = N_CV_folds)



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
  seed = 1,
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
  seed = 1,
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| message: false
#| label: "cgg_over_100"
#| include: false
sustain_output_cgg100plus = run_OSA(
  prob_score = prob_score0[
    patient_data$`CGG (backfilled)` >= 100,,],
  score_vals = score_vals,
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
sustain_output_cgg100minus = run_OSA(
  prob_score = prob_score0[
    patient_data$`CGG (backfilled)` < 100,,],
  score_vals = score_vals,
  SuStaInLabels = SuStaInLabels,
  N_startpoints = N_startpoints,
  N_S_max = N_S_max_stratified, 
  N_iterations_MCMC = N_iterations_MCMC, 
  output_folder = output_folder, 
  dataset_name = "under100", 
  use_parallel_startpoints = FALSE,
  seed = 1,
  plot = FALSE)



## ----------------------------------------------------------------------------------------------------
#| label: "fig-pvd1"
#| column: screen
#| fig-height: 15
#| fig-align: center
#| fig-cap: "Estimated event sequence models - overall and stratified by sex"
#| fig-cap-location: top
#| layout-ncol: 3
#| fig-subcap:
#|   - "All data"
#|   - "Males"
#|   - "Females"

figs = extract_figs_from_pickle(
  n_s = 1,
  dataset_name = dataset_name,
  output_folder = output_folder,
  score_vals = score_vals,
  biomarker_groups = biomarker_groups,
  biomarker_levels = biomarker_levels) |> 
  print()

fig_male = extract_figs_from_pickle(
  n_s = 1,
  dataset_name = "males",
  output_folder = output_folder,
  score_vals = score_vals,
  biomarker_groups = biomarker_groups,
  biomarker_levels = biomarker_levels) |> 
  print()

fig_female = extract_figs_from_pickle(
  n_s = 1,
  dataset_name = "females",
  output_folder = output_folder,
  score_vals = score_vals,
  biomarker_groups = biomarker_groups,
  biomarker_levels = biomarker_levels) |> 
  print()


## ----------------------------------------------------------------------------------------------------
#| label: "fig-pvd-by-cgg"
#| column: screen
#| fig-height: 15
#| fig-align: center
#| fig-cap: "positional variance diagram assuming one subgroup - overall and stratified by CGG repeats (<100 vs 100+)"
#| fig-cap-location: top
#| layout-ncol: 2
#| fig-subcap:
#|   - "CGG < 100"
#|   - "CGG 100+"

fig_under100 = extract_figs_from_pickle(
  n_s = 1,
  dataset_name = "under100",
  output_folder = output_folder,
  score_vals = score_vals,
  biomarker_plot_order = NULL,
  biomarker_groups = biomarker_groups,
  biomarker_levels = biomarker_levels) |> 
  print()

fig_over100 = extract_figs_from_pickle(
  n_s = 1,
  dataset_name = "over100",
  output_folder = output_folder,
  score_vals = score_vals,
  biomarker_groups = biomarker_groups,
  biomarker_levels = biomarker_levels) |> 
  print()



## ----------------------------------------------------------------------------------------------------
n_s = 4


## ----------------------------------------------------------------------------------------------------

figs = extract_figs_from_pickle(
  n_s = n_s,
  dataset_name = dataset_name,
  output_folder = output_folder,
  score_vals = score_vals,
  biomarker_groups = biomarker_groups,
  biomarker_levels = biomarker_levels)


## ----------------------------------------------------------------------------------------------------
#| label: "fig-pvd4"
#| layout-ncol: 4
#| fig-height: 15
#| fig-align: center
#| fig-cap: "positional variance diagrams for 4 subgroups"
#| fig-cap-location: top
#| column: screen
#| fig-subcap:
#|   - "Subgroup 1"
#|   - "Subgroup 2"
#|   - "Subgroup 3"
#|   - "Subgroup 4"
library(ggplot2)

figs |> 
  print_PVDs()



## ----------------------------------------------------------------------------------------------------
#| tbl-cap: !expr glue::glue("Subgroup demographics ({n_s} subgroups)")
#| label: tbl-sg_demos
#| results: asis

results = extract_results_from_pickle(
  n_s = n_s,
  dataset_name = dataset_name,
  output_folder = output_folder,
  biomarker_groups = biomarker_groups,
  biomarker_levels = biomarker_levels)

table_subtype_by_demographics(
    patient_data,
    subtype_and_stage_table = results$subtype_and_stage_table
    )




## ----------------------------------------------------------------------------------------------------
#| fig-cap: "Cross-validation information criterion"
#| label: fig-cvic

library(ggplot2)

temp = sustain_output |> attr("CV")
temp$CVIC |> plot_CVIC()



## ----------------------------------------------------------------------------------------------------
#| fig-cap: "Test set log-likelihood across folds"
#| label: fig-boxplot-loglik-cv
temp$loglike_matrix |> 
  plot_cv_loglik()


