#' Title
#'
#' @param biomarker_levels  todo
#' @param biomarker_groups todo
#'
#' @returns a [tibble::tbl_df]
#' @export
#'
construct_biomarker_events_table <- function(
    biomarker_levels,
    biomarker_groups
    )
{
  biomarker_levels |>
    get_biomarker_events_table() |>
    left_join(
      biomarker_groups,
      by = "biomarker"
    ) |>
    arrange(biomarker_group, biomarker, biomarker_level)
}
