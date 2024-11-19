#' Compile biomarker groups table
#'
#' @param biomarker_group_list todo
#'
#' @returns a [tibble::tbl_df]
#' @export
#' @examples
#' biomarker_groups_list = list(
#'   "group 1" = c("Biomarker 1", "Biomarker 2"),
#'   "group 2" = c("Biomarker 3", "Biomarker 4"),
#'   "group 3" = "Biomarker 5")
#'
#' biomarker_groups_list |> compile_biomarker_groups_table()
#'
compile_biomarker_groups_table = function(
    biomarker_group_list =
      compile_biomarker_group_list(...),
    colors =
      biomarker_group_list |>
      choose_biomarker_group_colors(),
    ...)
{
  biomarker_group_list |>
    stack() |>
    as_tibble() |>
    dplyr::rename(
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
