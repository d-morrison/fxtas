#' Title
#'
#' @param heatmap_data tibble with columns "position", "name", and "value"
#' @param label Label for color scale
#'
#' @return
#' @export
#'
plot_heatmap = function(heatmap_data, label = "Pr(marker in this position)")
{
  heatmap_data |>
    ggplot2::ggplot(ggplot2::aes(x = x, y = y, fill = heat)) +
    ggplot2::geom_tile() +
    ggplot2::xlab("Event Order") +
    # ggplot2::scale_fill_continuous(name = "Prob.") +
    ggplot2::theme(legend.position="bottom") +
    ggplot2::ylab("Biomarker") +
    # scale_fill_distiller(palette = "RdPu", name = "Prob.") +
    # theme_ipsum() +
    ggplot2::scale_fill_gradient(low="white", high="blue", name = label) +
    ggplot2::scale_y_discrete(limits = rev) +
    ggplot2::coord_fixed()
}
