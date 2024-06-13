pvd_lineplot <- function(figs, alpha_nochange = 0.25,
                          facet_labels = names(figs), y_title_size = 12,
                         y_text_size = 10, x_text_size = 12){
  if(length(figs) == 1){
    # extract data from pvd fig object
    dataset <- dplyr::bind_rows(figs[[1]]$data, .id = "facet")
  } else {
    # update list names
    names(figs) <- facet_labels
    # extract data from list of pvd fig object
    dataset <- dplyr::bind_rows(
      lapply(
        figs,
        function(x) x$data
      ),
      .id = "facet"
    ) |>
      mutate(
        facet = factor(facet, levels = names(figs))
      )
  }

  # additional processing
  plot_dataset <- dataset |>
    mutate(
      # extract order number
      Order = stringi::stri_extract_first_regex(
        `row number and name`, "[0-9]+"
      ) |>
        as.integer(),
      # right justify left facet, left justify right facet
      hjust = ifelse(
        facet == facet_labels[1],
        1,
        0
      ),
      # made FXTAS Stage label bold
      `event label` = ifelse(
        biomarker == "FXTAS Stage (0-5)*",
        paste0("<b>", `event label`, "</b>"),
        as.character(`event label`)
      )
    ) |>
    dplyr::select(`event name`, facet, Order, biomarker, group_color, `event label`, hjust) |>
    unique() |>
    arrange(`event name`, facet) |>
    mutate(
      Changed = n_distinct(Order) != 1,
      # (Order - dplyr::lag(Order)) != 0,
      .by = `event name`
    ) |>
    mutate(
      linesize = ifelse(
        biomarker == "FXTAS Stage (0-5)*",
        2,
        1
      ),
      alpha = ifelse(
        Changed,
        1,
        alpha_nochange
      )
    )

  # plot
  ggplot(
    plot_dataset,
    aes(
      x = facet,
      y = Order |> factor()
    )
  ) +
    ggtext::geom_richtext(
      aes(
        label = `event label`,
        hjust = hjust
      ),
      fill = NA,
      label.color = NA
    ) +
    geom_line(
      aes(
        group = `event name`
      ),
      color = plot_dataset$group_color,
      linewidth = plot_dataset$linesize,
      alpha = plot_dataset$alpha
    ) +
    scale_y_discrete(limits = rev) +
    labs(y = "Stage") +
    theme_classic() +
    theme(
      legend.position = "none",
      axis.title.x = element_blank(),
      axis.title.y = element_text(size = y_title_size),
      axis.text.y = element_text(size = y_text_size),
      axis.text.x = element_text(size = x_text_size)

    )

}






