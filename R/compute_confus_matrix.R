#' compute `confus_matrix` as in python version
#'
#' @param samples_sequence todo
#' @param biomarker_event_order todo
#'
#' @return a [tibble:tbl_df]
#' @export
#'
#' @examples
#' samples_sequence = matrix(
#`    nrow = 2,
#`    byrow = TRUE,
#`    dimnames = list(
#`      iteration = NULL,
#`      position = paste("Event #", 1:10)),
#`    data = paste(
#`      "biomarker",
#`      c(0,2,4,6,8,9,7,5,3,1,
#`        0,1,2,3,4,5,6,7,8,9)))
#' compute_confus_matrix(samples_sequence)
#'
compute_confus_matrix <-
  function(samples_sequence,
           biomarker_event_order =
             attr(samples_sequence, "biomarker_event_names")) {
    output =
      samples_sequence |>
      compute_position_frequencies() |>
      arrange_position_frequencies(biomarker_order = biomarker_event_order) |>
      pivot_wider(
        id_cols = "event name",
        values_from = all_of("proportion"),
        names_from = all_of("position"),
        values_fill = 0
      ) |>
      column_to_rownames("event name") |>
      select(colnames(samples_sequence)) |>
      as.matrix()

    names(dimnames(output)) = c("event name", "position")

    return(output)
  }
