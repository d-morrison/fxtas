plot.PF = function(PFs)
{
  PFs |>
    ggplot(
      aes(
        x = position,
        y = "Event Name",
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

