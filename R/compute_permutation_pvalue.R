#' Compute permutation test p-value
#'
#' @inheritParams plot_permutation_results
#'
#' @returns a [numeric()]
#' @export
#'
compute_permutation_pvalue = function(
    permuted_test_stats,
    observed_test_stat)
{
  upper = mean(observed_test_stat >= permuted_test_stats)
  lower = mean(observed_test_stat <= permuted_test_stats)
  pval = 2*min(upper, lower)
}
