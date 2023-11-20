#' Title
#'
#' @param biomarker_group_list
#'
#' @return
#' @export
#'
compile_biomarker_groups_table = function(
    biomarker_group_list =
      compile_biomarker_group_list(...),
    colors =
      names(biomarker_group_list) |>
      choose_biomarker_group_colors(),
    ...)
{
  biomarker_group_list |>
  stack() |>
    as_tibble() |>
    rename(
      biomarker  = values,
      biomarker_group = ind)  |>
    mutate(
      biomarker_group =
        biomarker_group |>
        factor(levels = names(biomarker_group_list))) |>
    left_join(
      colors,
      by = "biomarker_group"
    )


}
