format_samples_sequence = function(
    samples_sequence = results$samples_sequence,
    biomarker_event_names =
      biomarker_levels |>
      get_biomarker_event_names(),
    results,
    biomarker_levels =
      results$biomarker_levels)
{
  samples_sequence[] = biomarker_event_names[samples_sequence + 1]
  dimnames(samples_sequence) =
    # dim(samples_sequence) |>
    # lapply(seq_len) |>
    # set_names(c("subgroup", "position", "iteration"))
    list(
    "subgroup" = NULL,
    "position" = seq_len(dim(samples_sequence)[2]) |> as.character(),
    "iteration" = NULL)
  return(samples_sequence)

}