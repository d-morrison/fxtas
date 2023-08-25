set_samples_sequence_dimnames = function(
    samples_sequence,
    biomarker_levels)
{

  # not sure this is correct
  events_table = biomarker_levels |> get_biomarker_events_table()
  stopifnot(dim(samples_sequence)[2] == nrow(events_table))
  dimnames(samples_sequence)[2] = events_table$biomarker_level
  return(samples_sequence)
}
