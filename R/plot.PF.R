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
    geom_tile() +
    # scale_fill_identity() +
    scale_fill_gradient(
      low = "gray",
      high = "red")+
    scale_y_discrete(limits = rev) +
    xlab('SuStaIn Stage') +
    ylab(NULL) +
    theme_bw() +
    theme(
      legend.position = "bottom",
      axis.text.y =
        ggtext::element_markdown(
          hjust = 0,
          size = size.y)
    ) +
    labs(fill = color_label)

  to_return |>
    structure(class = c("PVD", class(to_return)))
}

