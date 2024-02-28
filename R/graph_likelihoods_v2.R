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

  data =
    likelihoods |>
    format_likelihoods()


  labels = data |> slice_head(n = 1, by = name)

  data |>
    ggplot(
      aes(
        x = Iteration,
        y = value,
        col = name
      )) +
    geom_line(alpha = alpha) +
    # ggplot2::annotate(
    #   "text",
    #   x = 10000,
    #   y = labels$value,
    #   label = labels$name
    # ) +
    # facet_wrap(~name) +
    ylab("log-likelihood") +
    theme_bw()
}
