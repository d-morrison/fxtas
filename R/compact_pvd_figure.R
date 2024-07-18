#' plot compact pvd: figure
#'

compact_pvd_figure <- function(
    plot_dataset,
    tile_height,
    y_text_size,
    facet_names,
    # facet_label_size,
    legend.position,
    scale_colors
    ){
  # set tile width
  tile_width = 1

  nlevels <- plot_dataset |> pull(level) |> unique() |> length()

  # create level color scales
  if(length(scale_colors) != nlevels){
    stop("`scale_colors` must be the same length as the number of levels",
         " (number of levels = ", nlevels, ")")
  }

  ## update: add colors as arguments
  level2=colorRampPalette(c("white", scale_colors[1])) # level 2
  level3=colorRampPalette(c("white", scale_colors[2])) # level 3
  level4=colorRampPalette(c("white", scale_colors[3])) # level 4
  level5=colorRampPalette(c("white", scale_colors[4])) # level 5
  level6=colorRampPalette(c("white", scale_colors[5])) # level 6

  level2_scale <- level2(100)
  level3_scale <- level3(100)
  level4_scale <- level4(100)
  level5_scale <- level5(100)
  level6_scale <- level6(100)

  scale_limits <- c(0, 1)

  # facet labeller - currently throws updated API message
  facet_labeller <- function(variable, value){
    facet_names[value]
  }

  # figure
  fig <- ggplot() +
    # layer for biomarker level 2
    geom_tile(
      data = plot_dataset |> filter(level == 2),
      aes(
        x = position,
        y = forcats::fct_inorder(biomarker_label),
        fill = proportion,
        width = tile_width,
        height = tile_height
      ),
      alpha = 0.75
    ) +
    scale_fill_gradient(
      low = level2_scale[10],
      high = level2_scale[100],
      limits = scale_limits,
      breaks = c(0, 0.5, 1),
      guide = guide_colorbar(title = "Pr(Stage)<sub>2</sub>", order = 1)
    ) +
    # guides(fill = guide_legend(title = "Pr(Stage)<sub>2</sub>")) +
    ggnewscale::new_scale_fill() +
    # layer for biomarker level 3
    geom_tile(
      data = plot_dataset |> filter(level == 3),
      aes(
        x = position,
        y = forcats::fct_inorder(biomarker_label),
        fill = proportion,
        width = tile_width,
        height = tile_height
      ),
      alpha = 0.75
    ) +
    scale_fill_gradient(
      low = level3_scale[10],
      high = level3_scale[100],
      limits = scale_limits,
      breaks = c(0, 0.5, 1),
      guide = guide_colorbar(title = "Pr(Stage)<sub>3</sub>", order = 2)
    ) +
    # guides(fill = guide_legend(title = "Pr(Stage)<sub>3</sub>")) +
    ggnewscale::new_scale_fill() +
    # layer for biomarker level 4
    geom_tile(
      data = plot_dataset |> filter(level == 4),
      aes(
        x = position,
        y = forcats::fct_inorder(biomarker_label),
        fill = proportion,
        width = tile_width,
        height = tile_height
      ),
      alpha = 0.75
    ) +
    scale_fill_gradient(
      low = level4_scale[10],
      high = level4_scale[100],
      limits = scale_limits,
      breaks = c(0, 0.5, 1),
      guide = guide_colorbar(title = "Pr(Stage)<sub>4</sub>", order = 3)
    ) +
    # guides(fill = guide_legend(title = "Pr(Stage)<sub>4</sub>")) +
    ggnewscale::new_scale_fill() +
    # layer for biomarker level 5
    geom_tile(
      data = plot_dataset |> filter(level == 5),
      aes(
        x = position,
        y = forcats::fct_inorder(biomarker_label),
        fill = proportion,
        width = tile_width,
        height = tile_height
      ),
      alpha = 0.75
    ) +
    scale_fill_gradient(
      low = level5_scale[10],
      high = level5_scale[100],
      limits = scale_limits,
      breaks = c(0, 0.5, 1),
      guide = guide_colorbar(title = "Pr(Stage)<sub>5</sub>", order = 4)
    ) +
    # guides(fill = guide_legend(title = "Pr(Stage)<sub>5</sub>")) +
    ggnewscale::new_scale_fill() +
    # layer for biomarker level 6
    geom_tile(
      data = plot_dataset |> filter(level == 6),
      aes(
        x = position,
        y = forcats::fct_inorder(biomarker_label),
        fill = proportion,
        width = tile_width,
        height = tile_height
      ),
      alpha = 0.75
    ) +
    scale_fill_gradient(
      low = level6_scale[10],
      high = level6_scale[100],
      limits = scale_limits,
      breaks = c(0, 0.5, 1),
      guide = guide_colorbar(title = "Pr(Stage)<sub>6</sub>", order = 5)
    ) +
    # guides(fill = guide_legend(title = "Pr(Stage)<sub>6</sub>")) +
    # reverse order of y-axis (biomarkers)
    ggplot2::scale_y_discrete(limits = rev) +
    # frame x axis
    scale_x_continuous(expand = expansion(add = c(0.5, 2))) +
    # update axis labels
    labs(x = "Sequential order") +
    # wrap over facet levels
    facet_wrap(
      ~facet,
      labeller = facet_labeller # update facet labels
    ) +
    # plot theme
    theme_bw() +
    theme(
      legend.position = legend.position, # add color scale info in figure caption,
      legend.title = element_markdown(), # markdown for legends
      legend.byrow = TRUE,
      legend.box = 'horizontal',
      legend.justification = ,
      legend.margin = margin(0, 0.15, 0, -0.45, "cm"),
      axis.title.y = element_blank(),
      axis.text.y = ggtext::element_markdown(
        size = y_text_size
      ), # allow markdown for coloring
      # strip.text = ggtext::element_markdown(size = facet_label_size) # allow markdown for labels
      strip.text = ggtext::element_markdown() # allow markdown for labels
    )

  return(fig)
}
