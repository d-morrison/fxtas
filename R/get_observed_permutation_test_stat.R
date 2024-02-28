#' Compute permutation test statistic
#'
#' @param output_folder where to find the relevant pickle files
#'
#' @returns the observed test statistic (a [numeric()] scalar)
#' @export
#'
get_observed_permutation_test_stat = function(
    output_folder)
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
