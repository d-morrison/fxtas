#' Plot compact PVD
#' @export

# tmp function using list of extract_figs_from_pickle
plot_compact_pvd <- function(
    figs,
    tile_height = 1,
    y_text_size = 9,
    # facet_label_size = 8,
    facet_label_prefix = names(figs),
    legend.position = "none",
    scale_colors = c("red", "blue", "purple4", "darkgreen", "magenta")
){
  # extract and prep data from fig list
  plot_dataset <- compact_pvd_data_prep(figs = figs)
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





# old <- function(
#     figs = list(),
#     tile_height = 1,
#     facet_label = NULL
# ){
#
#   tile_width = 1
#
#   # create figure
#   if(length(figs) == 1){
#     # extract data from pvd fig object
#     dataset <- dplyr::bind_rows(figs[[1]]$data, .id = "facet")
#     # determine biomarker event order
#     event_order <- dataset |>
#       dplyr::select(`row number and name`, `event name`, biomarker) |>
#       mutate(
#         Order = sub("\\D*(\\d+).*", "\\1", `row number and name`) |> as.numeric()
#       ) |>
#       mutate(
#         `event order` = min(Order),
#         .by = `biomarker`
#       ) |>
#       # dplyr::select(
#       #   biomarker, position
#       # ) |>
#       arrange(`event order`) |>
#       mutate(
#         biomarker = forcats::fct_inorder(biomarker)
#       ) |>
#       dplyr::select(biomarker, `event order`) |>
#       unique()
#
#     # update biomarker levels in dataset
#     plot_dataset <- dataset |>
#       # convert biomarker to factor with event order levels
#       mutate(
#         biomarker = factor(
#           biomarker,
#           levels = levels(event_order$biomarker)
#         )
#       ) |>
#       # arrange by biomarker levels
#       arrange(biomarker) |>
#       # create biomarker labels for figure
#       mutate(
#         biomarker_label = glue::glue(
#           "<i style='color:{group_color}'>{biomarker}</i>"
#         ) |>
#           forcats::fct_inorder()
#       ) |>
#       dplyr::select(
#         facet, biomarker, biomarker_label, position, proportion, level
#       )
#
#     # facet names
#     facet_names <- as.list(figs[[1]]$labels$title)
#     names(facet_names) <- paste0(1:length(figs))
#     # facet labeller - currently throws updated API message
#     facet_labeller <- function(variable, value){
#       facet_names[value]
#     }
#
#     # generate color ramps/scales for the different biomarker levels
#     reds=colorRampPalette(c("white", "red")) # level 2
#     blues=colorRampPalette(c("white", "blue")) # level 3
#     purples=colorRampPalette(c("white", "purple")) # level 4
#     greens=colorRampPalette(c("white", "forestgreen")) # level 5
#     magentas=colorRampPalette(c("white", "magenta1")) # level 6
#
#     red_scale <- reds(100)
#     blue_scale <- blues(100)
#     purple_scale <- purples(100)
#     green_scale <- greens(100)
#     magenta_scale <- magentas(100)
#
#     scale_limits <- c(0, 1)
#
#     # figure
#     fig <- ggplot() +
#       # layer for biomarker level 2
#       geom_tile(
#         data = plot_dataset |> filter(level == 2),
#         aes(
#           x = position,
#           y = forcats::fct_inorder(biomarker_label),
#           fill = proportion,
#           width = tile_width,
#           height = tile_height
#         ),
#         alpha = 0.75
#       ) +
#       scale_fill_gradient(
#         low = red_scale[10],
#         high = red_scale[100],
#         limits = scale_limits
#       ) +
#       ggnewscale::new_scale_fill() +
#       # layer for biomarker level 3
#       geom_tile(
#         data = plot_dataset |> filter(level == 3),
#         aes(
#           x = position,
#           y = forcats::fct_inorder(biomarker_label),
#           fill = proportion,
#           width = tile_width,
#           height = tile_height
#         ),
#         alpha = 0.75
#       ) +
#       scale_fill_gradient(
#         low = blue_scale[10],
#         high = blue_scale[100],
#         limits = scale_limits
#       ) +
#       ggnewscale::new_scale_fill() +
#       # layer for biomarker level 4
#       geom_tile(
#         data = plot_dataset |> filter(level == 4),
#         aes(
#           x = position,
#           y = forcats::fct_inorder(biomarker_label),
#           fill = proportion,
#           width = tile_width,
#           height = tile_height
#         ),
#         alpha = 0.75
#       ) +
#       scale_fill_gradient(
#         low = purple_scale[10],
#         high = purple_scale[100],
#         limits = scale_limits
#       ) +
#       ggnewscale::new_scale_fill() +
#       # layer for biomarker level 5
#       geom_tile(
#         data = plot_dataset |> filter(level == 5),
#         aes(
#           x = position,
#           y = forcats::fct_inorder(biomarker_label),
#           fill = proportion,
#           width = tile_width,
#           height = tile_height
#         ),
#         alpha = 0.75
#       ) +
#       scale_fill_gradient(
#         low = green_scale[10],
#         high = green_scale[100],
#         limits = scale_limits
#       ) +
#       ggnewscale::new_scale_fill() +
#       # layer for biomarker level 6
#       geom_tile(
#         data = plot_dataset |> filter(level == 6),
#         aes(
#           x = position,
#           y = forcats::fct_inorder(biomarker_label),
#           fill = proportion,
#           width = tile_width,
#           height = tile_height
#         ),
#         alpha = 0.75
#       ) +
#       scale_fill_gradient(
#         low = magenta_scale[10],
#         high = magenta_scale[100],
#         limits = scale_limits
#       ) +
#       # reverse order of y-axis (biomarkers)
#       ggplot2::scale_y_discrete(limits = rev) +
#       # frame x axis
#       scale_x_continuous(expand = expansion(add = c(0.5, 2))) +
#       # update axis labels
#       labs(x = "SuStaIn Stage") +
#       # wrap over facet levels
#       facet_wrap(
#         ~facet,
#         labeller = facet_labeller # update facet labels
#       ) +
#       # plot theme
#       theme_bw() +
#       theme(
#         legend.position = "none", # add color scale info in figure caption
#         axis.title.y = element_blank(),
#         axis.text.y = ggtext::element_markdown() # allow markdown for coloring
#       )
#   }
#
#   if(length(figs) > 1){
#     # extract data from pvd fig object
#     dataset <- dplyr::bind_rows(
#       lapply(
#         1:length(figs),
#         function(x) figs[[x]]$data
#       ),
#       .id = "facet"
#     )
#
#     # determine biomarker event order
#     event_order <- dataset |>
#       dplyr::select(`row number and name`, `event name`, biomarker) |>
#       mutate(
#         Order = sub("\\D*(\\d+).*", "\\1", `row number and name`) |> as.numeric()
#       ) |>
#       mutate(
#         `event order` = min(Order),
#         .by = `biomarker`
#       ) |>
#       # dplyr::select(
#       #   biomarker, position
#       # ) |>
#       arrange(`event order`) |>
#       mutate(
#         biomarker = forcats::fct_inorder(biomarker)
#       ) |>
#       dplyr::select(biomarker, `event order`) |>
#       unique()
#
#     # update biomarker levels in dataset
#     plot_dataset <- dataset |>
#       # convert biomarker to factor with event order levels
#       mutate(
#         biomarker = factor(
#           biomarker,
#           levels = levels(event_order$biomarker)
#         )
#       ) |>
#       # arrange by biomarker levels
#       arrange(biomarker) |>
#       # create biomarker labels for figure
#       mutate(
#         biomarker_label = glue::glue(
#           "<i style='color:{group_color}'>{biomarker}</i>"
#         ) |>
#           forcats::fct_inorder()
#       ) |>
#       dplyr::select(
#         facet, biomarker, biomarker_label, position, proportion, level
#       )
#
#     # facet names
#     facet_names <- lapply(
#       1:length(figs),
#       function(x) figs[[x]]$labels$title
#     )
#     names(facet_names) <- paste0(1:length(figs))
#     # facet labeller - currently throws updated API message
#     facet_labeller <- function(variable, value){
#       facet_names[value]
#     }
#
#     # generate color ramps/scales for the different biomarker levels
#     reds=colorRampPalette(c("white", "red")) # level 2
#     blues=colorRampPalette(c("white", "blue")) # level 3
#     purples=colorRampPalette(c("white", "purple")) # level 4
#     greens=colorRampPalette(c("white", "forestgreen")) # level 5
#     magentas=colorRampPalette(c("white", "magenta1")) # level 6
#
#     red_scale <- reds(100)
#     blue_scale <- blues(100)
#     purple_scale <- purples(100)
#     green_scale <- greens(100)
#     magenta_scale <- magentas(100)
#
#     scale_limits <- c(0, 1)
#
#     # figure
#     fig <- ggplot() +
#       # layer for biomarker level 2
#       geom_tile(
#         data = plot_dataset |> filter(level == 2),
#         aes(
#           x = position,
#           y = forcats::fct_inorder(biomarker_label),
#           fill = proportion,
#           width = tile_width,
#           height = tile_height
#         ),
#         alpha = 0.75
#       ) +
#       scale_fill_gradient(
#         low = red_scale[10],
#         high = red_scale[100],
#         limits = scale_limits
#       ) +
#       ggnewscale::new_scale_fill() +
#       # layer for biomarker level 3
#       geom_tile(
#         data = plot_dataset |> filter(level == 3),
#         aes(
#           x = position,
#           y = forcats::fct_inorder(biomarker_label),
#           fill = proportion,
#           width = tile_width,
#           height = tile_height
#         ),
#         alpha = 0.75
#       ) +
#       scale_fill_gradient(
#         low = blue_scale[10],
#         high = blue_scale[100],
#         limits = scale_limits
#       ) +
#       ggnewscale::new_scale_fill() +
#       # layer for biomarker level 4
#       geom_tile(
#         data = plot_dataset |> filter(level == 4),
#         aes(
#           x = position,
#           y = forcats::fct_inorder(biomarker_label),
#           fill = proportion,
#           width = tile_width,
#           height = tile_height
#         ),
#         alpha = 0.75
#       ) +
#       scale_fill_gradient(
#         low = purple_scale[10],
#         high = purple_scale[100],
#         limits = scale_limits
#       ) +
#       ggnewscale::new_scale_fill() +
#       # layer for biomarker level 5
#       geom_tile(
#         data = plot_dataset |> filter(level == 5),
#         aes(
#           x = position,
#           y = forcats::fct_inorder(biomarker_label),
#           fill = proportion,
#           width = tile_width,
#           height = tile_height
#         ),
#         alpha = 0.75
#       ) +
#       scale_fill_gradient(
#         low = green_scale[10],
#         high = green_scale[100],
#         limits = scale_limits
#       ) +
#       ggnewscale::new_scale_fill() +
#       # layer for biomarker level 6
#       geom_tile(
#         data = plot_dataset |> filter(level == 6),
#         aes(
#           x = position,
#           y = forcats::fct_inorder(biomarker_label),
#           fill = proportion,
#           width = tile_width,
#           height = tile_height
#         ),
#         alpha = 0.75
#       ) +
#       scale_fill_gradient(
#         low = magenta_scale[10],
#         high = magenta_scale[100],
#         limits = scale_limits
#       ) +
#       # reverse order of y-axis (biomarkers)
#       ggplot2::scale_y_discrete(limits = rev) +
#       # frame x axis
#       scale_x_continuous(expand = expansion(add = c(0.5, 2))) +
#       # update axis labels
#       labs(x = "SuStaIn Stage") +
#       # wrap over facet levels
#       facet_wrap(
#         ~facet,
#         labeller = facet_labeller # update facet labels
#       ) +
#       # plot theme
#       theme_bw() +
#       theme(
#         legend.position = "none", # add color scale info in figure caption
#         axis.title.y = element_blank(),
#         axis.text.y = ggtext::element_markdown() # allow markdown for coloring
#       )
#   }
#
#   return(fig)
# }
