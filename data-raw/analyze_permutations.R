# args (passed in from .sbatch file)
# 1: first permutation seed (for job arrays)
# 3: permuting variable (must be a quoted column name, such as "Gender" - 1st argument to analyze_permutations.sbatch
# 2: stratifying level (can be "") - 2nd argument to analyze_permutations.sbatch

message('Starting at: ', Sys.time())

library(fxtas)
library(dplyr)

args = commandArgs(trailingOnly = TRUE)

if(length(args) == 0)
{
  message('no arguments found')
  permutations = 1:1000
  permuting_variables = "FX3*"
  stratifying_level = "Male"
} else
{
  message("args = ")
  print(args)
  start = args[1] |> as.numeric()
  permutations = start:(start+19)
  permuting_variables = args[2]

  stratifying_level = args[3]
  if(is.na(stratifying_level)) stratifying_level = ""

}

cli::cli_inform("permuting variables: {permuting_variables}")
cli::cli_inform("stratifying level: {stratifying_level}")

output_folder =
  fs::path(
    here::here(),
    "output/output.fixed_CV/permutations",
    stratifying_level,
    permuting_variables |> fs::path_sanitize() |> paste(collapse = "-"))

permuted_test_stats = extract_permuted_likelihoods(
    permuting_variables = permuting_variables,
    permutations = permutations,
    output_folder = output_folder
  )

write_permuted_test_stats(
  permuted_test_stats = permuted_test_stats,
  output_folder = output_folder
)

message("ending `analyze_permutations.R`")
