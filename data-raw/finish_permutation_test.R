library(fxtas)
output_folder = fs::path(here::here(), "output/output.fixed_CV")

{
  results_females_first = extract_results_from_pickle(
    n_s = 1,
    rda_filename = "data.RData",
    dataset_name = "females",
    output_folder = output_folder)

  results_males_first = extract_results_from_pickle(
    n_s = 1,
    rda_filename = "data.RData",
    dataset_name = "females",
    output_folder = output_folder)

  llik_females = results_females_first$samples_likelihood
  llik_males = results_males_first$samples_likelihood

  test_stat = mean(llik_females) + mean(llik_males)
}

permutation_results = output_folder |> fs::path("permutation_test_stats")
perm
files = dir(permutation_results, full = TRUE)
for (cur_file in files)
{
  load(cur_file)
}
