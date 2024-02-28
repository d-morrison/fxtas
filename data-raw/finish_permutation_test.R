library(fxtas)

test_stats = collect_permutation_test_stats()

# compare with observed test stat
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

library(ggplot2)

tibble(test_stats = test_stats) |>
  ggplot(aes(x = .data$test_stats)) +
  geom_histogram(bins = 100, alpha = .7) +
  xlim(range(c(test_stats, test_stat))) +
  xlab("test statistic (mean log-likelihood)") +
  geom_vline(aes(xintercept = test_stat, col = 'observed test statistic')) +
  theme_bw() +
  theme(legend.position = "bottom")
