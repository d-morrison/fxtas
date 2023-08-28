format_samples_sequence = function(
    samples_sequence = results$samples_sequence,
    biomarker_event_names =
      biomarker_levels |>
      get_biomarker_event_names(),
    results,
    biomarker_levels =
      results$biomarker_levels)
{

  new_dimnames =
    list(
      subgroup = dim(samples_sequence)[1] |> seq_len(),
      position = dim(samples_sequence)[2] |> seq_len(),
      iteration = dim(samples_sequence)[3] |> seq_len())

  samples_sequence2 =
    # +1 b/c python is 0-indexed:
    biomarker_event_names[samples_sequence + 1] |>
    array(
      dimnames = new_dimnames,
      dim = new_dimnames |> sapply(length))




}
