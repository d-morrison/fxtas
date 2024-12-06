#' Format results list extracted from pickle file
#'
#' @param results pickle file contents
#' @param biomarker_labels biomarker labels
#' @param biomarker_levels biomarker levels
#' @param biomarker_events_table table of biomarker events (excluding base level)
#' @param biomarker_event_names vector of biomarker event names
#' @param format_sst should the subtype and stage table be formatted? (doesn't work for cross-validation fold pickle-files)
#'
#' @returns a `"SuStaIn-model"` object (extends [list()])
#'
format_results_list <- function(
    results,
    biomarker_labels = names(biomarker_levels),
    biomarker_levels = NULL,
    biomarker_events_table =
      biomarker_levels |> get_biomarker_events_table(),
    biomarker_event_names =
      biomarker_events_table |> dplyr::pull(biomarker_level),
    format_sst = TRUE)
{

  results$samples_sequence =
    results$samples_sequence |>
    format_samples_sequence(
      results = results,
      biomarker_event_names = biomarker_event_names)

  if(format_sst)
  {
    results$subtype_and_stage_table =
      results |>
      extract_subtype_and_stage_table()
  }

  class(results) = c("SuStaIn-model", class(results))

  return(results)
}
