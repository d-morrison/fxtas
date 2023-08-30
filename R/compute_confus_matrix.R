#' Title
#'
#' @param samples_sequence
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
compute_confus_matrix = function(
    samples_sequence)
{
  output =
    samples_sequence |>
    compute_position_frequencies() |>
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
  results =
    samples_sequence |>
    as_tibble() |>
    pivot_longer(
      names_to = "position",
      values_to = "event name",
      col = everything()) |>
    count(`event name`, position) |>
    mutate(
      position = position |> factor(levels = 1:ncol(samples_sequence)),
      proportion = n / nrow(samples_sequence)) |>
    select(-n)

   order =
     results |>
     arrange(`event name`, position) |>
     slice_head(by = `event name`) |>
     arrange(position, desc(proportion), `event name`)

   results =
     results |>
     mutate(
       `event name` =
         factor(`event name`, levels = order$`event name`)) |>
     arrange(`event name`)

   return(results)
}
