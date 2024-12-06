#' Title
#'
#' @param biomarker_levels todo
#'
#' @returns a [ggplot2::ggplot]
#' @export
#' @examples
#' df = test_data_v1
#' biomarker_groups = compile_biomarker_groups_table(dataset = df)
#' biomarker_varnames =
#'   biomarker_groups |>
#'   dplyr::pull("biomarker")
#'
#' biomarker_levels =
#'   df |>
#'   get_levels(biomarker_varnames, keep_labels = TRUE)
#'
#'  get_biomarker_events_table(biomarker_levels)
get_biomarker_events_table <- function(biomarker_levels)
{
  to_return =
    biomarker_levels |>
    tibble::enframe() |>
    tidyr::unnest_longer(value) |>
    dplyr::rename(
      biomarker = name,
      level = value) |>
    dplyr::relocate(biomarker, .before = everything()) |>
    dplyr::mutate(
      # biomarker = factor(biomarker, levels = names(biomarker_levels)),
      # level = level |> str_replace("Yes", "Present"), # this might cause issues
      biomarker_level =
        if_else(
          level == "Yes",
          biomarker,
          paste(biomarker, level, sep = ": "))
    ) |>
    dplyr::mutate(
      .by = biomarker,
      levels = paste(level, collapse = ", "),
      level = dplyr::row_number()) |>
    dplyr::filter(level > 1) |>
    arrange(level, biomarker) # |>
    # dplyr::mutate(biomarker_level = factor(biomarker_level, levels = biomarker_level))
  to_return
}

get_biomarker_event_names <- function(
    biomarker_levels,
    biomarker_events_table = get_biomarker_events_table(biomarker_levels))
{
  biomarker_events_table |>  dplyr::pull(biomarker_level)
}
