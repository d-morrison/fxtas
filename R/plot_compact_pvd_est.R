#'  @title Plot compact PVD with point estimates only
#'  @export
#'

plot_compact_pvd_est <- function(
    figs,
    tile_height = 1,
    y_text_size = 9,
    # facet_label_size = 8,
    facet_label_prefix = names(figs),
    legend.position = "none",
    scale_colors = c("red", "blue", "purple4", "darkgreen", "magenta")
){
  # extract and prep data from fig list
  plot_dataset <- compact_pvd_est_data_prep(figs = figs)
  # facet labels
  facet_names <- compact_pvd_facet_labels(figs = figs, facet_label_prefix = facet_label_prefix)
  # generate figure
  compact_pvd_figure(
    plot_dataset,
    tile_height = tile_height,
    y_text_size = y_text_size,
    facet_names = facet_names,
    # facet_label_size = facet_label_size,
    legend.position = legend.position,
    scale_colors = scale_colors
  )
}
