#' Format results list extracted from pickle file
#'
#' @param results pickle file contents
#' @param biomarker_labels biomarker labels
#' @param biomarker_groups biomarker groupings
#' @param biomarker_levels biomarker levels
#' @param biomarker_events_table table of biomarker events (excluding base level)
#' @param biomarker_event_names vector of biomarker event names
#'
#' @return
#'
format_results_list = function(
    results,
    biomarker_labels = names(biomarker_levels),
    biomarker_groups = NULL,
    biomarker_levels = NULL,
    biomarker_events_table =
      biomarker_levels |> get_biomarker_events_table(),
    biomarker_event_names =
      biomarker_events_table |> pull(biomarker_level))
{

  results$samples_sequence =
    results$samples_sequence |>
    format_samples_sequence(
      results = results,
      biomarker_event_names = biomarker_event_names)

  results$subtype_and_stage_table =
    results |>
    extract_subtype_and_stage_table()

  return(results)
}
