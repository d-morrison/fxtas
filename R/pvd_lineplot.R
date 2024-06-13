figs = list(fig_males_first, fig_females_first)



alluvial_plot <- function(figs){
  if(length(figs) == 1){
    # extract data from pvd fig object
    dataset <- dplyr::bind_rows(figs[[1]]$data, .id = "facet")
  } else {
    # extract data from list of pvd fig object
    dataset <- dplyr::bind_rows(
      lapply(
        1:length(figs),
        function(x) figs[[x]]$data
      ),
      .id = "facet"
    )
  }

  dataset <- dataset |>
    mutate(
      Order = stringi::stri_extract_first_regex(
        `row number and name`, "[0-9]+"
      ) |>
        as.numeric() |>
        factor(),
      hjust = ifelse(
        facet == 1,
        1,
        0
      ),
      `event label` = ifelse(
        biomarker == "FXTAS Stage (0-5)*",
        paste0("<b>", `event label`, "</b>"),
        as.character(`event label`)
      )
    )

  dataset_changed <- dataset |>
    dplyr::select(
      facet, `event name`, biomarker, Order, group_color
    ) |>
    unique() |>
    pivot_wider(
      id_cols = c(`event name`, biomarker, group_color),
      names_from = facet,
      values_from = Order,
      names_prefix = "facet_"
    ) |>
    mutate(
      Changed = ifelse(
        facet_1 == facet_2, "No", "Yes"
      )
    ) |>
    # filter(Changed == "Yes" | biomarker == "FXTAS Stage (0-5)*") |>
    # dplyr::select(-Changed) |>
    pivot_longer(
      cols = c(facet_1, facet_2),
      names_to = "facet",
      values_to = "Order"
    ) |>
    mutate(
      facet = gsub("facet_", "", facet),
      linesize = ifelse(
        biomarker == "FXTAS Stage (0-5)*",
        2,
        1
      ),
      alpha = ifelse(
        Changed == "Yes",
        1,
        0.25
      )
    )

  ggplot(
    dataset,
    aes(
      x = facet,
      y = Order
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
      data = dataset_changed,
      aes(
        x = facet,
        y = Order,
        group = `event name`
      ),
      color = dataset_changed$group_color,
      linewidth = dataset_changed$linesize,
      # alpha = dataset_changed$alpha,
      inherit.aes = FALSE
    ) +
    scale_y_discrete(limits = rev) +
    theme_classic() +
    theme(
      legend.position = "none"
    )

}


alluvial_plot(
  figs = list(
    fig_males_first,
    fig_females_first
  )
)



