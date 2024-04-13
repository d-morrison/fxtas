#' Compute permutation test statistic
#'
#' @param output_folder where to find the relevant pickle files
#' @param dataset_names [character()] vector of dataset name stems
#'
#' @returns the observed test statistic (a [numeric()] scalar)
#' @export
#'
get_observed_permutation_test_stat = function(
    output_folder,
    dataset_names)
{
  test_stat = 0

  for (cur in dataset_names)
  {
    results = extract_results_from_pickle(
      n_s = 1,
      rda_filename = "data.RData",
      dataset_name = cur,
      output_folder = output_folder)

    test_stat = test_stat + mean(results$samples_likelihood)
  }
  return(test_stat)
}
