
arrange_position_frequencies = function(position_frequencies, biomarker_order = NULL) {
  if (biomarker_order |> is.null()) {
    biomarker_order =
      position_frequencies |>
      order_biomarkers() |>
      pull("event name")
  }

  position_frequencies |>
    mutate(
      "event name" =
        .data$`event name` |>
        factor(levels = biomarker_order),
      "row number and name" =
        paste(as.numeric(.data$`event name`), .data$`event name`, sep = ") ")
    ) |>
    arrange(pick("event name")) |>
    relocate("row number and name", .before = "event name")
}
