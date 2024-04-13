#' Compute permutation test p-value
#'
#' @inheritParams plot_permutation_results
#'
#' @returns a [numeric()]
#' @export
#'
permutation_test = function(
    permuted_test_stats,
    observed_test_stat)
{
  upper = mean(observed_test_stat >= permuted_test_stats)
  lower = mean(observed_test_stat <= permuted_test_stats)
  pval = 2*min(upper, lower)
  pval = pval |>
    structure(
    class = "permutation_test",
    observed_test_stat = observed_test_stat,
    permuted_test_stats = permuted_test_stats
  )
}

#' Plot the distribution of a permuted test statistic
#'
#' @param object an object of class `"permutation_test`
#' @param ..., additional arguments (not used)
#'
#' @returns a [ggplot2::ggplot] constructing a histogram of the test statistic
#' @export
#'
#' @examples
autoplot.permutation_test = function(object, ...)
{
  plot_permutation_results(
    observed_test_stat = attr(object, "observed_test_stat"),
    permuted_test_stats = attr(object, "permuted_test_stats"))
}
