#' @title data prep function
#' @dev
tmp_data_prep <- function(x) {
  tmp <- x$data
  # determine biomarker event order
  event_order <- tmp |>
    dplyr::select(.data$`row number and name`,
                  .data$`event name`,
                  .data$biomarker) |>
    dplyr::mutate(Order = .data$`row number and name` |>
             sub("\\D*(\\d+).*", "\\1", x = _) |>
             as.numeric()) |>
    dplyr::mutate(`event order` = min(.data$Order),
           .by = .data$`biomarker`) |>
    # dplyr::select(
    #   biomarker, position
    # ) |>
    arrange(.data$`event order`) |>
    dplyr::mutate(biomarker = forcats::fct_inorder(.data$biomarker)) |>
    dplyr::select(.data$biomarker, .data$`event order`) |>
    unique()

  event_order_facet <- tmp |>
    dplyr::select(.data$`row number and name`,
                  .data$`event name`,
                  .data$biomarker) |>
    dplyr::mutate(Order = .data$`row number and name` |>
                    sub("\\D*(\\d+).*", "\\1", x = _) |>
                    as.numeric()) |>
    unique()

  plot_dataset <- merge(event_order_facet,
                        tmp,
                        by = c("row number and name",
                               "event name",
                               "biomarker")) |>
    dplyr::filter(.data$position == .data$Order) |>
    # convert biomarker to factor with event order levels
    dplyr::mutate(biomarker =
             .data$biomarker |>
             factor(levels = levels(event_order$biomarker))) |>
    # arrange by biomarker levels
    arrange(pick("biomarker")) |>
    # create biomarker labels for figure
    dplyr::mutate(
      biomarker_label = glue::glue("<i style='color:{group_color}'>{biomarker}</i>") |>
        forcats::fct_inorder()
    ) |>
    dplyr::select(
      .data$biomarker,
      .data$biomarker_label,
      .data$position,
      .data$proportion,
      .data$level
    )

  return(plot_dataset)
}

#### create plot for a given subtype ####
tmp_func <- function(plot_dataset,
                     y_position,
                     panel_title,
                     scale_colors,
                     tile_height,
                     tile_width,
                     y_text_size,
                     legend.position,
                     title_size = y_text_size) {
  # process color scales
  level2 = colorRampPalette(c("white", scale_colors[1])) # level 2
  level3 = colorRampPalette(c("white", scale_colors[2])) # level 3
  level4 = colorRampPalette(c("white", scale_colors[3])) # level 4
  level5 = colorRampPalette(c("white", scale_colors[4])) # level 5
  level6 = colorRampPalette(c("white", scale_colors[5])) # level 6

  level2_scale <- level2(100)
  level3_scale <- level3(100)
  level4_scale <- level4(100)
  level5_scale <- level5(100)
  level6_scale <- level6(100)

  scale_limits <- c(0, 1)

  # figure
  fig <- ggplot() +
    # layer for biomarker level 2
    ggplot2::geom_tile(
      data = plot_dataset |> dplyr::filter(.data$level == 2),
      aes(
        x = .data$position,
        y = forcats::fct_inorder(.data$biomarker_label),
        fill = .data$proportion,
        width = tile_width,
        height = tile_height
      ),
      alpha = 0.75
    ) +
    ggplot2::scale_fill_gradient(
      low = level2_scale[10],
      high = level2_scale[100],
      limits = scale_limits,
      breaks = c(0, 0.5, 1),
      guide = ggplot2::guide_colorbar(title = "Pr(Stage)<sub>2</sub>", order = 1)
    ) +
    # guides(fill = guide_legend(title = "Pr(Stage)<sub>2</sub>")) +
    ggnewscale::new_scale_fill() +
    # layer for biomarker level 3
    ggplot2::geom_tile(
      data = plot_dataset |> dplyr::filter(.data$level == 3),
      aes(
        x = .data$position,
        y = forcats::fct_inorder(.data$biomarker_label),
        fill = .data$proportion,
        width = tile_width,
        height = tile_height
      ),
      alpha = 0.75
    ) +
    ggplot2::scale_fill_gradient(
      low = level3_scale[10],
      high = level3_scale[100],
      limits = scale_limits,
      breaks = c(0, 0.5, 1),
      guide = ggplot2::guide_colorbar(title = "Pr(Stage)<sub>3</sub>", order = 2)
    ) +
    # guides(fill = guide_legend(title = "Pr(Stage)<sub>3</sub>")) +
    ggnewscale::new_scale_fill() +
    # layer for biomarker level 4
    ggplot2::geom_tile(
      data = plot_dataset |> dplyr::filter(.data$level == 4),
      aes(
        x = .data$position,
        y = forcats::fct_inorder(.data$biomarker_label),
        fill = .data$proportion,
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
      guide = ggplot2::guide_colorbar(title = "Pr(Stage)<sub>4</sub>", order = 3)
    ) +
    # guides(fill = guide_legend(title = "Pr(Stage)<sub>4</sub>")) +
    ggnewscale::new_scale_fill() +
    # layer for biomarker level 5
    ggplot2::geom_tile(
      data = plot_dataset |> dplyr::filter(.data$level == 5),
      aes(
        x = .data$position,
        y = forcats::fct_inorder(.data$biomarker_label),
        fill = .data$proportion,
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
      guide = ggplot2::guide_colorbar(title = "Pr(Stage)<sub>5</sub>", order = 4)
    ) +
    # guides(fill = guide_legend(title = "Pr(Stage)<sub>5</sub>")) +
    ggnewscale::new_scale_fill() +
    # layer for biomarker level 6
    ggplot2::geom_tile(
      data = plot_dataset |> dplyr::filter(.data$level == 6),
      aes(
        x = .data$position,
        y = forcats::fct_inorder(.data$biomarker_label),
        fill = .data$proportion,
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
      guide = ggplot2::guide_colorbar(title = "Pr(Stage)<sub>6</sub>", order = 5)
    ) +
    # guides(fill = guide_legend(title = "Pr(Stage)<sub>6</sub>")) +
    # reverse order of y-axis (biomarkers)
    ggplot2::scale_y_discrete(limits = rev, position = y_position) +
    # frame x axis
    ggplot2::scale_x_continuous(expand = ggplot2::expansion(add = c(0.5, 2))) +
    # update axis labels
    ggplot2::labs(x = "Sequential order", title = panel_title) +
    # wrap over facet levels
    # ggplot2::facet_wrap(
    #   ~facet,
    #   labeller = facet_labeller # update facet labels
    # ) +
    # plot theme
    ggplot2::theme_bw() +
    ggplot2::theme(
      legend.position = legend.position,
      # add color scale info in figure caption,
      legend.title = element_markdown(size = title_size),
      # markdown for legends
      legend.byrow = TRUE,
      legend.box = "horizontal",
      legend.justification = ,
      legend.margin = ggplot2::margin(0, 0.15, 0, -0.45, "cm"),
      axis.title.y = ggplot2::element_blank(),
      axis.title.x = ggtext::element_markdown(size = title_size),
      axis.text.y = ggtext::element_markdown(size = y_text_size),
      # allow markdown for coloring
      # strip.text = ggtext::element_markdown(size = facet_label_size) # allow markdown for labels
      # strip.text = ggtext::element_markdown() # allow markdown for labels
      plot.title = ggtext::element_markdown(hjust = 0.5, size = title_size)
    )

  return(fig)
}
