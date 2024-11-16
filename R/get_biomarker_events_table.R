#' Title
#'
#' @param biomarker_levels todo
#'
#' @returns a [ggplot2::ggplot]
#' @export
#'
get_biomarker_events_table = function(biomarker_levels)
{
  biomarker_levels |>
    stack() |>
    tibble() |>
    dplyr::rename(
      biomarker = ind,
      level = values) |>
    dplyr::relocate(biomarker, .before = everything()) |>
    mutate(
      biomarker = factor(biomarker, levels = names(biomarker_levels)),
      # level = level |> str_replace("Yes", "Present"), # this might cause issues
      biomarker_level =
        if_else(
          level == "Yes",
          biomarker,
          paste(biomarker, level, sep = ": "))
    ) |>
    mutate(
      .by = biomarker,
      levels = paste(level, collapse = ", "),
      level = dplyr::row_number()) |>
    filter(level > 1) |>
    arrange(level, biomarker) # |>
    # mutate(biomarker_level = factor(biomarker_level, levels = biomarker_level))

}

get_biomarker_event_names = function(
    biomarker_levels,
    biomarker_events_table = get_biomarker_events_table(biomarker_levels))
{
  biomarker_events_table |>  pull(biomarker_level)
}
