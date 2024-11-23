#' @title Plot SuStaIn Sequential Estimate
#'
#' @export
#'
plot_compact_pvd_est2 <- function(
    figs,
    tile_height = 1,
    tile_width = 1,
    y_text_size = 9,
    legend.position = "none",
    scale_colors = c("red", "blue", "purple4", "darkgreen", "magenta"),
    ...
){
  # prepare data from figure list
  #   unlike the other functions, the data will remain in a list, not combined
  figs_plot <- lapply(
    figs,
    function(x) tmp_data_prep(x)
  )
  # add the figure title as list names
  names(figs_plot) <- c(
    figs[[1]]$labels$title,
    figs[[2]]$labels$title,
    figs[[3]]$labels$title,
    figs[[4]]$labels$title
  )

  # create plot for each panel
  p <- lapply(
    1:length(figs_plot),
    function(x) tmp_func(
      figs_plot[[x]],
      y_position = dplyr::if_else(
        x %% 2 == 0,
        "right",
        "left"
      ),
      panel_title = names(figs_plot)[x],
      scale_colors = scale_colors,
      y_text_size = y_text_size,
      legend.position = legend.position,
      tile_height = tile_height,
      tile_width = tile_width,
      ...
    )
  )

  cowplot::plot_grid(
    plotlist = p,
    nrow = 2,
    ncol = 2
  )

}

#
# plot_compact_pvd_est2(figs)
