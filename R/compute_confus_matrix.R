compute_confus_matrix = function(
    samples_sequence,
    N_events = ncol(samples_sequence),
    biomarker_levels =
      samples_sequence |>
      attr("biomarker_levels"),
    event_names =
      biomarker_levels |>
      get_biomarker_events_table() |>
      pull(biomarker_level))
{
  samples_sequence |>
    apply(F = order, M = 1) |>
    apply(F = function(x)
      factor(x, levels = 1:N_events) |>
        table() |>
        proportions(), M = 1) |>
    t() |>
    set_rownames(event_names) |>
    set_colnames(
      paste("Event #", 1:N_events)
    )
}
