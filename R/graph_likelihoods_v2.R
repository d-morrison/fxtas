#' Title
#'
#' @param likelihoods
#' @param alpha
#'
#' @return
#' @export
#'
graph_likelihoods_v2 = function(
    likelihoods,
    alpha = 0.5)
{
  likelihoods |>
    format_likelihoods() |>
    tidyr::pivot_longer(
      cols = paste(1:ncol(likelihoods), "subtype(s)")
    ) |>
    ggplot(
      aes(
        x = Iteration,
        y = value,
        col = name
      )) +
    geom_line(alpha = alpha) +
    # facet_wrap(~name) +
    ylab("log-likelihood") +
    theme_bw()
}
