
compute_position_frequencies <- function(samples_sequence) {
  position_names = dimnames(samples_sequence)[[2]]
  if (is.null(position_names)) {
    position_names = seq_along(samples_sequence)
  }
  results =
    samples_sequence |>
    as_tibble() |>
    pivot_longer(names_to = "position",
                 values_to = "event name",
                 col = everything()) |>
    count(across(c("event name", "position"))) |>
    mutate(
      position = .data$position |> factor(levels = position_names),
      proportion = n / nrow(samples_sequence)
    ) |>
    select(-n)

  class(results) =
    c("PF", class(results))

  results
}


