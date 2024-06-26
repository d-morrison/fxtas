#' plot_compact_pvd: data prep
#'


compact_pvd_data_prep <- function(figs){
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

  # determine biomarker event order
  event_order <- dataset |>
    filter(facet == 1) |>
    dplyr::select(`row number and name`, `event name`, biomarker) |>
    mutate(
      Order = sub("\\D*(\\d+).*", "\\1", `row number and name`) |> as.numeric()
    ) |>
    mutate(
      `event order` = min(Order),
      .by = `biomarker`
    ) |>
    # dplyr::select(
    #   biomarker, position
    # ) |>
    arrange(`event order`) |>
    mutate(
      biomarker = forcats::fct_inorder(biomarker)
    ) |>
    dplyr::select(biomarker, `event order`) |>
    unique()

  # update biomarker levels in dataset
  plot_dataset <- dataset |>
    # convert biomarker to factor with event order levels
    mutate(
      biomarker = factor(
        biomarker,
        levels = levels(event_order$biomarker)
      )
    ) |>
    # arrange by biomarker levels
    arrange(biomarker) |>
    # create biomarker labels for figure
    mutate(
      biomarker_label = glue::glue(
        "<i style='color:{group_color}'>{biomarker}</i>"
      ) |>
        forcats::fct_inorder()
    ) |>
    dplyr::select(
      facet, biomarker, biomarker_label, position, proportion, level
    )

  return(plot_dataset)
}

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
#   }
#
#
# }
