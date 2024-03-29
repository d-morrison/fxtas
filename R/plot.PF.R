plot.PF = function(PFs, size.y = 12)
{
  PFs |>
    mutate(
      position = as.numeric(position)
    ) |>
    ggplot(
      aes(
        x = position,
        y = `event name`,
        fill = proportion
      )) +
    geom_tile() +
    # scale_fill_identity() +
    scale_fill_gradient(low = "gray", high = "red")+
    scale_y_discrete(limits = rev) +
    xlab('SuStaIn Stage') +
    ylab(NULL) +
    theme_bw() +
    theme(
      legend.position = "bottom",
      axis.text.y =
        element_markdown(hjust=0, size = size.y)
    ) +
    labs(fill = "Pr(stage)")
}

