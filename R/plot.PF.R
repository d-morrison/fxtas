plot.PF = function(PFs)
{
  PFs |>
    mutate(
      position = factor(position, levels = 1:n_distinct(position))
    ) |>
    ggplot(
      aes(
        x = position,
        y = `event name`,
        fill = proportion
      )) +
    geom_tile() +
    # scale_fill_identity() +
    scale_fill_gradient(low = "white", high = "red")+
    scale_y_discrete(limits = rev) +
    xlab('SuStaIn Stage') +
    ylab(NULL) +
    theme_bw() +
    theme(
      legend.position = "bottom",
      axis.text.y =
        element_markdown(
          hjust=0,
          color = PFs |> distinct(`event name`, group_color) |> pull( "group_color"))
    ) +
    labs(fill = "Pr(stage)")
}

