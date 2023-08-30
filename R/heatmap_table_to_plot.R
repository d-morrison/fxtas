heatmap_table_to_plot = function(heatmap_table)
{
  heatmap_table |>
  ggplot(
    aes(
      x = SuStaIn.Stage,
      y = biomarker,
      fill =
        rgb(
          r = R,              #Specify Bands
          g = G,
          b = B,
          maxColorValue = 1),
    )) +
    scale_fill_identity() +
    scale_y_discrete(limits = rev) +
    xlab('SuStaIn Stage') +
    ylab(NULL) +
    geom_raster(show.legend = FALSE) +
    theme_bw()
}
