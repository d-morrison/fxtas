#' Plot change in Stage ranking
#'
#' @param figs
#' @param alpha_nochange
#' @param facet_labels
#' @param y_title_size
#' @param text_size
#' @param y_text_size
#' @param x_text_size
#'
#' @export

pvd_lineplot <- function(figs,
                         min_alpha = 0.25,
                         max_alpha = 1,
                         facet_labels = names(figs),
                         text_size = 3.4,
                         y_lab = "Sequential order",
                         y_title_size = 12,
                         y_text_size = 10,
                         x_text_size = 12) {
  if (length(figs) == 1) {
    # extract data from pvd fig object
    dataset <- dplyr::bind_rows(figs[[1]]$data, .id = "facet")
  } else {
    # update list names
    names(figs) <- facet_labels
    # extract data from list of pvd fig object
    dataset <- dplyr::bind_rows(lapply(figs,
                                       function(x)
                                         x$data),
                                .id = "facet") |>
      mutate(facet = factor(facet, levels = names(figs)))
  }

  # additional processing
  plot_dataset <- dataset |>
    mutate(
      # extract order number
      Order = stringi::stri_extract_first_regex(`row number and name`, "[0-9]+") |>
        as.integer(),
      # right justify left facet, left justify right facet
      hjust = ifelse(facet == facet_labels[1],
                     1,
                     0),
      # made FXTAS Stage label bold
      `event label` = ifelse(
        biomarker == "FXTAS Stage (0-5)*",
        paste0("<b>", `event label`, "</b>"),
        as.character(`event label`)
      )
    ) |>
    dplyr::select(`event name`,
                  facet,
                  Order,
                  biomarker,
                  group_color,
                  `event label`,
                  hjust) |>
    unique() |>
    arrange(`event name`, facet) |>
    mutate(
      # logical: did sequence change
      Changed = n_distinct(Order) != 1,
      # magnitude of sequence change
      Change = abs(diff(Order)),
      .by = `event name`
    ) |>
    mutate(
      linesize = ifelse(biomarker == "FXTAS Stage (0-5)*",
                        2,
                        1),
      facet_order = case_when(facet == facet_labels[1] ~ 1,
                              facet == facet_labels[2] ~ 1.15
      )
    )

  # alpha scaling #
  max_order <- max(plot_dataset$Order)
  alpha_mult <- ((max_alpha - min_alpha) / (max_order - 1))

  plot_dataset <- plot_dataset |>
    dplyr::mutate(
      alpha = (Change * alpha_mult) + min_alpha
    )

  facet_x_labels <- c(
    glue::glue('<p "style = text-align: right">{facet_labels[1]}</p>'),
    glue::glue('<p "style = text-align: left">{facet_labels[2]}</p>')
  )

  # plot
  ggplot(plot_dataset,
         aes(x = facet_order,
             y = Order |> factor())) +
    ggtext::geom_richtext(
      aes(label = `event label`,
          hjust = hjust),
      fill = NA,
      label.color = NA,
      size = text_size
    ) +
    geom_line(
      aes(group = `event name`),
      color = plot_dataset$group_color,
      linewidth = plot_dataset$linesize,
      alpha = plot_dataset$alpha
    ) +
    scale_x_continuous(
      limits = c(0.65, 1.5),
      breaks = c(1, 1.15),
      labels = facet_x_labels
    ) +
    scale_y_discrete(limits = rev, breaks=NULL) +
    labs(y = y_lab) +
    theme_classic() +
    theme(
      legend.position = "none",
      axis.title.x = element_blank(),
      axis.title.y = ggtext::element_markdown(size = y_title_size),
      axis.text.y = ggtext::element_markdown(size = y_text_size),
      axis.text.x = ggtext::element_markdown(size = x_text_size,
                                             hjust = plot_dataset[["hjust"]])
    )

}
