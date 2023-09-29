#' compute `confus_matrix` as in python version
#'
#' @param samples_sequence
#' @param biomarker_event_order
#'
#' @return
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
compute_confus_matrix = function(
    samples_sequence,
    biomarker_event_order =
      samples_sequence |>
      attr("biomarker_event_names"))
{
  output =
    samples_sequence |>
    compute_position_frequencies() |>
    arrange_position_frequencies(
      biomarker_order = biomarker_event_order) |>
    pivot_wider(
      id_cols = "event name",
      values_from = proportion,
      names_from = position,
      values_fill = 0) |>
    column_to_rownames("event name") |>
    select(colnames(samples_sequence)) |>
    as.matrix()

  names(dimnames(output)) = c("event name", "position")

  return(output)
}

compute_position_frequencies = function(samples_sequence)
{
  position_names = dimnames(samples_sequence)[[2]]
  if(is.null(position_names))
  {
    position_names = 1:ncol(samples_sequence)
  }
  results =
    samples_sequence |>
    as_tibble() |>
    pivot_longer(
      names_to = "position",
      values_to = "event name",
      col = everything()) |>
    count(`event name`, position) |>
    mutate(
      position = position |> factor(levels = position_names),
      proportion = n / nrow(samples_sequence)) |>
    select(-n)

  return(results)
}

order_biomarkers = function(position_frequencies)
{

  order =
    position_frequencies |>
    arrange(`event name`, desc(proportion), position) |>
    slice_head(by = `event name`) |>
    arrange(position, desc(proportion), `event name`)

}

arrange_position_frequencies = function(
    position_frequencies,
    biomarker_order = NULL)
{
  if(biomarker_order |> is.null())
  {
    biomarker_order =
      position_frequencies |>
      order_biomarkers() |>
      pull(`event name`)
  }

  position_frequencies |>
    mutate(
      `event name` =
        factor(`event name`, levels = biomarker_order)) |>
    arrange(`event name`)
}
