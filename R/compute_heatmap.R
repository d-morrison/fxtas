compute_heatmap = function(
    samples_sequence,
    biomarker_labels,
    colour_mat,
    stage_biomarker_index,
    stage_score,
    N_z = length(num_scores),
    N_bio = length(biomarker_labels),
    num_scores = unique(stage_score))
{
  N_events = ncol(samples_sequence)

  # Construct confusion matrix (vectorized)
  # We compare `samples_sequence` against each position
  # Sum each time it was observed at that point in the sequence
  # And normalize for number of samples/sequences
  # confus_matrix = (samples_sequence==np.arange(N_events)[:, None, None]).sum(1) / samples_sequence.shape[0]

  confus_matrix = samples_sequence |>
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

  return(confus_matrix_c)
}
