#' Create positional variance diagram (PVD)
#'
#' @param PFs
#' @param size.y
#' @param color_label
#'
#' @return a "PVD" object (extends [ggplot2::ggplot()])
#' @export
#'
plot.PF = function(
    PFs,
    size.y = 12,
    color_label = "Pr(stage)")
{
  to_return =
    PFs |>
    mutate(
      position = as.numeric(position)
    ) |>
    ggplot(
      aes(
        x = position,
        y = `event label`,
        fill = proportion
      )) +
    ggplot2::geom_tile() +
    # scale_fill_identity() +
    ggplot2::scale_fill_gradient(
      low = "gray",
      high = "red")+
    ggplot2::scale_y_discrete(limits = rev) +
    ggplot2::xlab('SuStaIn Stage') +
    ggplot2::ylab(NULL) +
    ggplot2::theme_bw() +
    ggplot2::theme(
      legend.position = "bottom",
      axis.text.y =
        ggtext::element_markdown(
          hjust = 0,
          size = size.y)
    ) +
    ggplot2::labs(fill = color_label)

  to_return |>
    structure(class = c("PVD", class(to_return)))
}

