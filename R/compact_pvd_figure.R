#' plot compact pvd: figure
#'

compact_pvd_figure <- function(
    plot_dataset,
    tile_height = 1,
    facet_names = NULL
    ){
  # set tile width
  tile_width = 1

  # create level color scales
  reds=colorRampPalette(c("white", "red")) # level 2
  blues=colorRampPalette(c("white", "blue")) # level 3
  purples=colorRampPalette(c("white", "purple")) # level 4
  greens=colorRampPalette(c("white", "forestgreen")) # level 5
  magentas=colorRampPalette(c("white", "magenta1")) # level 6

  red_scale <- reds(100)
  blue_scale <- blues(100)
  purple_scale <- purples(100)
  green_scale <- greens(100)
  magenta_scale <- magentas(100)

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
      low = red_scale[10],
      high = red_scale[100],
      limits = scale_limits
    ) +
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
      low = blue_scale[10],
      high = blue_scale[100],
      limits = scale_limits
    ) +
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
      low = purple_scale[10],
      high = purple_scale[100],
      limits = scale_limits
    ) +
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
      low = green_scale[10],
      high = green_scale[100],
      limits = scale_limits
    ) +
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
      low = magenta_scale[10],
      high = magenta_scale[100],
      limits = scale_limits
    ) +
    # reverse order of y-axis (biomarkers)
    ggplot2::scale_y_discrete(limits = rev) +
    # frame x axis
    scale_x_continuous(expand = expansion(add = c(0.5, 2))) +
    # update axis labels
    labs(x = "SuStaIn Stage") +
    # wrap over facet levels
    facet_wrap(
      ~facet,
      labeller = facet_labeller # update facet labels
    ) +
    # plot theme
    theme_bw() +
    theme(
      legend.position = "none", # add color scale info in figure caption
      axis.title.y = element_blank(),
      axis.text.y = ggtext::element_markdown(), # allow markdown for coloring
      strip.text = ggtext::element_markdown() # allow markdown for labels
    )

  return(fig)
}
