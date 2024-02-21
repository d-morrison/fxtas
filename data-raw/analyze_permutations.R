library(fxtas)
output_folder = fs:path(here::here(), "output/output.fixed_CV")
output_folder |> fs::path("pickle_files") |> dir()


if(FALSE)
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


n_permutations = 1000
permuted_test_stats = numeric(length = n_permutations)
for (p in 1:n_permutations)
{
  message('analyzing permutation ', p)
  results_females_first = extract_results_from_pickle(
    n_s = 1,
    rda_filename = "data.RData",
    dataset_name = paste("females", p, sep = "_p"),
    output_folder = output_folder)

  results_males_first = extract_results_from_pickle(
    n_s = 1,
    rda_filename = "data.RData",
    dataset_name = paste("males", p, sep = "_p"),
    output_folder = output_folder)

  llik_females = results_females_first$samples_likelihood
  llik_males = results_males_first$samples_likelihood
  cur_test_stat = mean(llik_females) + mean(llik_males)
  permuted_test_stats[p] = cur_test_stat

}

save.image(file = "permutations.RData")
