#' Title
#'
#' @param samples_sequence
#' @param samples_f
#' @param n_samples
#' @param score_vals
#' @param biomarker_labels
#' @param ml_f_EM
#' @param cval
#' @param subtype_order
#' @param biomarker_order
#' @param title_font_size
#' @param stage_font_size
#' @param stage_label
#' @param stage_rot
#' @param stage_interval
#' @param label_font_size
#' @param label_rot
#' @param cmap
#' @param biomarker_colours
#' @param figsize
#' @param subtype_titles
#' @param separate_subtypes
#' @param save_path
#' @param save_kwargs
#'
#' @return
#' @export
#'
plot_positional_var = function(
    samples_sequence,
    samples_f,
    n_samples,
    score_vals,
    biomarker_labels=NULL,
    ml_f_EM=NULL,
    cval=FALSE,
    subtype_order=NULL,
    biomarker_order=NULL,
    title_font_size=12,
    stage_font_size=10,
    stage_label='SuStaIn Stage',
    stage_rot=0,
    stage_interval=1,
    label_font_size=10,
    label_rot=0,
    cmap="original",
    biomarker_colours=NULL,
    figsize=NULL,
    subtype_titles=NULL,
    separate_subtypes=FALSE,
    save_path=NULL,
    save_kwargs=NULL)
{
  # Get the number of subtypes
  N_S = samples_sequence |> nrow()
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
  stage_score = score_vals |> unravel_stage_score()
  # Get the scores and their number
  num_scores = unique(stage_score)
  N_z = length(num_scores)
  # Extract which biomarkers have which zscores/stages
  stage_biomarker_index = rep(1:N_bio, times = N_z)
  stage_biomarker_index = stage_biomarker_index[IX_select]
  # Warn user of reordering if labels and order given
  if (!is.null(biomarker_labels) & !is.null(biomarker_order))
    warning(
      "Both labels and an order have been given. The labels will be reordered according to the given order!"
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
  if(cmap == "original")
  {
    # Hard-coded colours: hooray!
    colour_mat = rbind(
      c(1, 0, 0),
      c(1, 0, 1),
      c(0, 0, 1),
      c(0.5, 0, 1),
      c(0, 1, 1),
      c(0, 1, 0.5)) |>
      head(N_z)

    # We only have up to 5 default colours, so double-check
    if (nrow(colour_mat) < N_z)
    {
      stop(paste("Colours are only defined for", nrow(colour_mat), " z-scores!"))
    }
  } else
  {
    stop()
  }

  # Check biomarker label colours
  # If custom biomarker text colours are given
  if(!is.null(biomarker_colours))
  {
    biomarker_colours = check_biomarker_colours(
      biomarker_colours, biomarker_labels
    )
    # Default case of all-black colours
    # Unnecessary, but skips a check later
  } else{
    biomarker_colours = rep("black", length(biomarker_labels))
  }
  # Flag to plot subtypes separately
  if (separate_subtypes)
  {
    nrows = ncols = 1
  } else
  {
    # Determine number of rows and columns (rounded up)
    if(N_S == 1)
    {
      nrows = ncols = 1
    } else if(N_S < 3)
    {
      nrows = 1; ncols = N_S;
    } else if (N_S < 7)
    {
      nrows = 2; ncols = as.integer(ceiling(N_S / 2))
    } else
    {
      nrows = 3; ncols = as.integer(ceiling(N_S / 3))
    }
  }

  # Total axes used to loop over
  total_axes = nrows * ncols
  # Create list of single figure object if not separated
  if(separate_subtypes)
  {
    subtype_loops = N_S
  } else
  {
    subtype_loops = 1
  }

  # Container for all figure objects
  figs = list()
  # Loop over figures (only makes a diff if separate_subtypes=True)
  for (i in 1:subtype_loops)
  {
    # Create the figure and axis for this subtype loop
    figs[i] = list()

    this_samples_sequence = samples_sequence[subtype_order[i],,] |> t()
    N_events = ncol(this_samples_sequence)

    # Construct confusion matrix (vectorized)
    # We compare `this_samples_sequence` against each position
    # Sum each time it was observed at that point in the sequence
    # And normalize for number of samples/sequences
    # confus_matrix = (this_samples_sequence==np.arange(N_events)[:, None, None]).sum(1) / this_samples_sequence.shape[0]

    confus_matrix = this_samples_sequence |>
      apply(F = order, M = 1) |>
      apply(F = function(x)
        factor(x, levels = 1:N_events) |>
          table() |>
          proportions(), M = 1) |>
      t()

    # Define the confusion matrix to insert the colours
    # Use 1s to start with all white
    confus_matrix_c = array(
      data = 1,
      dim = c(N_bio, N_events, 3),
      dimnames = list(
        biomarker = biomarker_labels,
        `SuStaIn Stage` = 1:N_events,
        color = c("R","G","B")
      ))

    # Loop over each z-score event
    for (j in 1:N_z)
    {
      z = num_scores[j]
      # Determine which colours to alter
      # I.e. red (1,0,0) means removing green & blue channels
      # according to the certainty of red (representing z-score 1)
      alter_level = colour_mat[j,] == 0
      # Extract the uncertainties for this score
      confus_matrix_score = confus_matrix[(stage_score == z), ]
      # Subtract the certainty for this colour
      subtractand1 =
        confus_matrix_score |>
        array(dim = c(dim(confus_matrix_score), sum(alter_level)))

      confus_matrix_c[
        stage_biomarker_index[stage_score==z],
        ,
        alter_level

      ] = confus_matrix_c[
        stage_biomarker_index[stage_score==z],
        ,
        alter_level,
        drop = FALSE
      ] - subtractand1

      # # Subtract the certainty for this colour
      # confus_matrix_c[, , alter_level] =
      #   confus_matrix_c[, , alter_level] -  np.tile(
      #   confus_matrix_score.reshape(N_bio, N_events, 1),
      #   (1, 1, alter_level.sum())
      # )
    }


    if (!is.null(subtype_titles))
    {
      title_i = subtype_titles[i]
    } else
    {
      # Add axis title
      if (!cval)
      {
        temp_mean_f = colMeans(samples_f)

        # Shuffle vals according to subtype_order
        # This defaults to previous method if custom order not given
        vals = temp_mean_f[subtype_order]

        if (!is.infinite(n_samples))
        {
          title_i = glue::glue("Subtype {i+1} (f={vals[i] |> round(2)}, n={round(vals[i] * n_samples)})")
        } else
        {
          title_i = glue::glue("Subtype {i+1} (f={vals[i] |> round(2)})")
        }

      } else
      {
        title_i = glue::glue("Subtype {i+1} cross-validated")
      }

    }

    heatmap_table =
      confus_matrix_c |>
      as.data.frame.table() |>
      pivot_wider(
        id_cols = c("biomarker","SuStaIn.Stage"),
        names_from = "color",
        values_from = "Freq") |>
      arrange(biomarker, SuStaIn.Stage)

    # Plot the colourized matrix

    plot1 =
      ggplot(
        heatmap_table,
        aes(
          x = SuStaIn.Stage,
          y = biomarker,
          fill =
            rgb(
              r = R,              #Specify Bands
              g = G,
              b = B,
              maxColorValue = 1),
        )) +
      scale_fill_identity() +
      scale_y_discrete(limits = rev) +
      xlab('SuStaIn Stage') +
      ylab(NULL) +
      ggtitle(title_i) +
      geom_raster(show.legend = FALSE) +
      theme_bw()


    figs[[i]][j] = plot1
    #https://medium.com/@tobias.stalder.geo/plot-rgb-satellite-imagery-in-true-color-with-ggplot2-in-r-10bdb0e4dd1f

  }
  return(figs)

}
