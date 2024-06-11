#' Plot permutation test results
#'
#' @param permuted_test_stats a [numeric()] vector
#' @param observed_test_stat a [numeric()] with length 1
#'
#' @returns an object of class `"permutation-test-results"`, which extends [ggplot2::ggplot()] by adding a `p-value` attribute.
#' @export
#'
plot_permutation_results = function(
    permuted_test_stats,
    observed_test_stat)
{

  pval = permutation_test(
    observed_test_stat = observed_test_stat,
    permuted_test_stats = permuted_test_stats
  )

  plot1 =
    tibble::tibble(permuted_test_stats = permuted_test_stats) |>
    ggplot2::ggplot(ggplot2::aes(x = .data$permuted_test_stats)) +
    ggplot2::geom_histogram(bins = 100, alpha = .7) +
    ggplot2::xlab("test statistic (mean log-likelihood)") +
    ggplot2::ylab('number of permuted datasets') +
    ggplot2::geom_vline(
      ggplot2::aes(
        xintercept = observed_test_stat,
        col =
          paste0(
            'observed test statistic (p = ',
            pval |> scales::pvalue(),
            ")"))) +
    ggplot2::theme_bw() +
    ggplot2::labs(col = "") +
    ggplot2::theme(legend.position = "bottom")

  to_return =
    plot1 |>
    structure(
      pvalue = pval,
      class = c("permutation-test-plot", class(plot1)))
  return(to_return)
}
