# args
# 1: first permutation seed (for job arrays)
# 2: stratifying level (can be "")
# 3: permuting variable
library(fxtas)
library(dplyr)

args = commandArgs(trailingOnly = TRUE) |> as.numeric()

if(length(args) == 0)
{
  message('no arguments found')
  permutations = 1:1000
  stratifying_level = "Male"
  permuting_variables = "FX3*"
} else
{
  message("args = ", args)
  start = args[1] |> as.numeric()
  permutations = start:(start+19)
  stratifying_level = args[2]
  permuting_variables = args[3]

}

output_folder =
  fs::path(
    here::here(),
    "output/output.fixed_CV/permutations",
    stratifying_level)

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
