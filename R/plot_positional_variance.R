#' Plot positional variance diagram
#' @inheritParams format_results_list
#' @param samples_sequence todo
#' @param samples_f todo
#' @param n_samples todo
#' @param score_vals todo
#' @param biomarker_labels todo
#' @param ml_f_EM todo
#' @param cval todo
#' @param subtype_order todo
#' @param biomarker_order todo
#' @param title_font_size todo
#' @param stage_font_size todo
#' @param stage_label todo
#' @param stage_rot todo
#' @param stage_interval todo
#' @param label_font_size todo
#' @param label_rot todo
#' @param cmap a [character]
#' @param biomarker_colours a [character] vector of colors
#' @param subtype_titles todo
#' @param separate_subtypes todo
#' @param save_path todo
#' @param save_kwargs todo
#' @param results todo
#' @param biomarker_levels todo
#' @param biomarker_groups biomarker groupings
#' @param biomarker_events_table todo
#' @param biomarker_event_names todo
#' @param biomarker_plot_order todo
#' @param synchronize_y_axes todo
#' @inheritDotParams plot.PF
#' @returns a `"PVD.list` (a [list] of `PVD` objects from [plot.PF()])
#' @export
#'
plot_positional_var = function(
    results,
    samples_sequence = results$samples_sequence,
    samples_f = results$samples_f,
    n_samples = results$ml_subtype |> nrow(),
    score_vals = build_score_vals(biomarker_levels),
    biomarker_labels = names(biomarker_levels),
    biomarker_groups = NULL,
    biomarker_levels = NULL,
    biomarker_events_table =
      biomarker_levels |> get_biomarker_events_table(),
    biomarker_event_names =
      biomarker_events_table |> pull(biomarker_level),
    biomarker_plot_order = NULL,
    ml_f_EM = NULL,
    cval = FALSE,
    subtype_order = NULL,
    biomarker_order = NULL,
    title_font_size = 12,
    stage_font_size = 10,
    stage_label = 'Sequential order',
    stage_rot=0,
    stage_interval=1,
    label_font_size=10,
    label_rot=0,
    cmap="original",
    biomarker_colours=NULL,
    subtype_titles=NULL,
    separate_subtypes=FALSE,
    save_path=NULL,
    save_kwargs=NULL,
    synchronize_y_axes = FALSE,
    ...)
{

  # Get the number of subtypes
  N_S = dim(samples_sequence)[1]
  # Get the number of features/biomarkers
  N_bio = score_vals |> nrow()
  # Check that the number of labels given match
  if (!is.null(biomarker_labels))
    stopifnot(length(biomarker_labels) == N_bio)
  # Set subtype order if not given
  if (is.null(subtype_order))
  {
    # Determine order if info given
    if (!is.null(ml_f_EM))
    {
      subtype_order = ml_f_EM |> order(decreasing = TRUE)

      # Otherwise determine order from samples_f
    } else
    {
      subtype_order = samples_f |> rowMeans() |> order(decreasing = TRUE)
      # np.argsort(np.mean(samples_f, 1))[::-1]
    }
  }

  # Unravel the stage scores from score_vals
  stage_score = score_vals |> as.vector()
  IX_select = which(stage_score != 0)
  stage_score = stage_score[IX_select]

  # Get the scores and their number
  num_scores = unique(stage_score)
  N_z = length(num_scores)
  # Extract which biomarkers have which zscores/stages
  stage_biomarker_index = rep(1:N_bio, times = N_z)
  stage_biomarker_index = stage_biomarker_index[IX_select]
  # Warn user of reordering if labels and order given
  if (!is.null(biomarker_labels) & !is.null(biomarker_order))
    warning(
      "Both labels and an order have been given.\n",
      "The labels will be reordered according to the given order!"
    )
  if (!is.null(biomarker_order))
  {
    # self._plot_biomarker_order is not suited to this version
    # Ignore for compatability, for now
    # One option is to reshape, sum position, and lowest->highest determines order
    if (length(biomarker_order) > N_bio)
      biomarker_order = 1:N_bio
    # Otherwise use default order
  } else
  {
    biomarker_order = 1:N_bio
  }

  # If no labels given, set dummy defaults
  if (is.null(biomarker_labels))
  {
    biomarker_labels = paste("Biomarker", 1:N_bio)
    # Otherwise reorder according to given order (or not if not given)
  } else
  {
    biomarker_labels = biomarker_labels[biomarker_order]
  }
  # Check number of subtype titles is correct if given
  if (!is.null(subtype_titles))
  {
    stopifnot(length(subtype_titles) == N_S)
  }
  # Z-score colour definition
  colour_mat = get_colour_mat(cmap,N_z)

  # Check biomarker label colours
  # If custom biomarker text colours are given
  if(!is.null(biomarker_colours))
  {
    biomarker_colours = check_biomarker_colours(
      biomarker_colours,
      biomarker_labels
    )
    # Default case of all-black colours
    # Unnecessary, but skips a check later
  } else{
    biomarker_colours = rep("black", length(biomarker_labels))
  }

  # Container for all figure objects
  figs = list()
  # Loop over figures
  for (i in 1:N_S)
  {
    # Create the figure and axis for this subtype loop

    # confus_matrix_c =
    #   samples_sequence[subtype_order[i],,] |>
    #   t() |>
    #   compute_heatmap(
    #     biomarker_labels = biomarker_labels,
    #     colour_mat = colour_mat,
    #     stage_biomarker_index = stage_biomarker_index,
    #     stage_score = stage_score,
    #     biomarker_event_names =
    #       biomarker_event_names
    #   )

    if (!is.null(subtype_titles))
    {
      title_i = subtype_titles[i]
    } else
    {
      title_i = get_title_i(
        samples_f,
        subtype_order,
        n_samples,
        cval,
        i
      )
    }

    # heatmap_table =
    #   confus_matrix_c |>
    #   as.data.frame.table() |>
    #   as_tibble() |>
    #   pivot_wider(
    #     id_cols = c("biomarker","SuStaIn.Stage"),
    #     names_from = "color",
    #     values_from = "Freq") |>
    #   arrange(biomarker, SuStaIn.Stage)
    #
    # # Plot the colourized matrix
    #
    # plot1 =
    #   heatmap_table |>
    #   heatmap_table_to_plot() +
    #   ggtitle(title_i)

    PFs <-
      samples_sequence[subtype_order[i],,] |>
      t() |>
      compute_position_frequencies() |>
      simplify_biomarker_names(cols = "event name") |>

      # get biomarker names
      left_join(
        biomarker_events_table |>
          simplify_biomarker_names(cols = c("biomarker", "biomarker_level")),
        by = c("event name" = "biomarker_level")
      ) |>
      # get biomarker groups and colors
      left_join(
        biomarker_groups |>
          simplify_biomarker_names(cols = "biomarker"),
        by = c("biomarker")
      ) |>
      arrange_position_frequencies(
        biomarker_order = biomarker_plot_order
      ) |>
      mutate(
        `event label` =
          glue("<i style='color:{group_color}'>{`row number and name`}</i>"),
        `event label` = if_else(
          .data$biomarker_group == "stage",
          paste0("**", .data$`event label`, "**"),
          .data$`event label`
        ),
        `event label` =
          .data$`event label` |>
          factor(levels = .data$`event label` |> unique())
      )


    if(synchronize_y_axes)
    {
      biomarker_plot_order = PFs |> attr("biomarker_order")
    }

    PF.plot =
      PFs  |>
      plot.PF(...) +
      ggplot2::ggtitle(title_i)


    figs[[i]] = structure(
      PF.plot,
      biomarker_order = PFs |> attr("biomarker_order"),
      # alt_plot = plot1,
      title = title_i)
    #https://medium.com/@tobias.stalder.geo/plot-rgb-satellite-imagery-in-true-color-with-ggplot2-in-r-10bdb0e4dd1f

  }

  if(length(figs) == 1)
  {
    figs = figs[[1]]
  } else
  {
    class(figs) = c("PVD.list", class(figs))
  }

  figs = figs |>
    structure(
      biomarker_event_names = biomarker_event_names
    )

  return(figs)

}
