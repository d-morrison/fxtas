library(fxtas)
library(dplyr)
output_folder = fs::path(here::here(), "output/output.fixed_CV/permutations/Male")

# stratifying_variables = "FX3*"
stratifying_variables = c("Gender")
# stratifying_variables = NULL
permuting_variables = "FX3*"
# permuting_variables = "Gender"

n_permutations = 1000
args = commandArgs(trailingOnly = TRUE) |> as.numeric()

if(length(args)==0)
{
  message('no arguments found')
  permutations = 1:n_permutations
} else
{
  message("args = ", args)
  start = args[1]
  permutations = start:(start+19)
}

message('analyzing permutations: ', paste(range(permutations), collapse = "-"))

permuted_test_stats =
  numeric(length = length(permutations)) |>
  magrittr::set_names(permutations |> as.character())

for (p in permutations)
{
  message('analyzing permutation ', p)

  cur_test_stat = 0

  file_path = fs::path(output_folder, "data.rds")
  patient_data = readRDS(file = file_path)

  levels =
    patient_data |>
    dplyr::pull(all_of(permuting_variables)) |>
    unique() |>
    as.character()

  message('levels are:')
  print(levels)

  for (cur_level in levels)
  {
    results_cur_level = extract_results_from_pickle(
      n_s = 1,
      rda_filename = "data.RData",
      dataset_name = paste(cur_level, p, sep = "_p"),
      output_folder = output_folder)


    llik_cur_level = results_cur_level$samples_likelihood

    cur_test_stat = cur_test_stat + mean(llik_cur_level)
  }

  permuted_test_stats[as.character(p)] = cur_test_stat

}

file_path =
  fs::path(
    output_folder,
    "test_stats",
    paste0("permuted_test_stats", args[1], "-", args[1] + 19, ".rds"))

message("file_path:\n", file_path)
message("permuted_test_stats = \n")
print(permuted_test_stats)

if(file.exists(file_path)) file.remove(file_path)

permuted_test_stats |> saveRDS(file = file_path)

message("ending `analyze_permutations.R`")
