# args
# 1: first permutation seed (for job arrays)
# 2: stratifying level (can be NULL)

library(fxtas)
library(dplyr)
output_folder =
  fs::path(
    here::here(),
    "output/output.fixed_CV/permutations/Male")

# stratifying_variables = "FX3*"
stratifying_variables = c("Gender")
# stratifying_variables = NULL
permuting_variables = "FX3*"
# permuting_variables = "Gender"

args = commandArgs(trailingOnly = TRUE) |> as.numeric()

if(length(args) == 0)
{
  message('no arguments found')
  permutations = 1:1000
} else
{
  message("args = ", args)
  start = args[1] |> as.numeric()
  permutations = start:(start+19)
}

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
