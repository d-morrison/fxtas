#' Compute permutation test p-value
#'
#' @param n_permutations how many permutations to use (`Inf` means use all in `permuted_test_stats`)
#' @inheritParams plot_permutation_results
#'
#' @returns a [numeric()]
#' @export
#'
permutation_test = function(
    permuted_test_stats,
    observed_test_stat,
    n_permutations = Inf)
{

  if(n_permutations < length(permuted_test_stats))
  {
    permuted_test_stats = permuted_test_stats[1:n_permutations]
  }

  upper = mean(observed_test_stat >= permuted_test_stats)
  lower = mean(observed_test_stat <= permuted_test_stats)
  pval = 2*min(upper, lower)
  pval = pval |>
    structure(
    class = c("permutation_test", class(pval)),
    observed_test_stat = observed_test_stat,
    permuted_test_stats = permuted_test_stats
  )
}

#' Plot the distribution of a permuted test statistic
#'
#' @param object an object of class `"permutation_test"`
#' @param ..., additional arguments (not used)
#'
#' @returns a [ggplot2::ggplot] constructing a histogram of the test statistic
#' @export
autoplot.permutation_test = function(object, ...)
{
  plot_permutation_results(
    observed_test_stat = attr(object, "observed_test_stat"),
    permuted_test_stats = attr(object, "permuted_test_stats"))
}

#' print method for "permutation_test" objects
#'
#' @param x a [permutation_test()] object
#' @param ... unused
#' @export
#' @return `x`, invisibly
#'
print.permutation_test = function(x, ...)
{
  x |> scales::pvalue() |> print()
  invisible(x)
}
