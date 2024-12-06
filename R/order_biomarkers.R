order_biomarkers <- function(position_frequencies) {
  order =
    position_frequencies |>
    arrange(pick("event name"), desc(pick("proportion")), pick("position")) |>
    slice_head(by = all_of("event name")) |>
    arrange(pick("position"), desc(pick("proportion")), pick("event name")) |>
    dplyr::mutate(
      row_num = dplyr::row_number(),
      `row number and name` =
        glue::glue("{row_num}: {`event name`}")
    )

  order

}
