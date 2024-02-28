#' Plot permutation test results
#'
#' @param permuted_test_stats a [numeric()] vector
#' @param observed_test_stat a [numeric()] with length 1
#'
#' @returns a [ggplot2::ggplot()]
#' @export
#'
plot_permutation_results = function(
    permuted_test_stats,
    observed_test_stat)
{

  xrange = range(c(permuted_test_stats, observed_test_stat))

  tibble::tibble(permuted_test_stats = permuted_test_stats) |>
    ggplot2::ggplot(ggplot2::aes(x = .data$permuted_test_stats)) +
    ggplot2::geom_histogram(bins = 100, alpha = .7) +
    ggplot2::xlim(xrange) +
    ggplot2::xlab("test statistic (mean log-likelihood)") +
    ggplot2::geom_vline(
      ggplot2::aes(
        xintercept = observed_test_stat,
        col = 'observed test statistic')) +
    ggplot2::theme_bw() +
    ggplot2::theme(legend.position = "bottom")

}
