#' Compile biomarker groups table
#'
#' @param dataset passed to [compile_biomarker_group_list()]
#' @param biomarker_group_list todo
#' @param colors which colors to use
#' @inheritDotParams compile_biomarker_group_list
#'
#' @returns a [tibble::tbl_df]
#' @export
#' @examples
#' biomarker_group_list = list(
#'   "group 1" = c("Biomarker 1", "Biomarker 2"),
#'   "group 2" = c("Biomarker 3", "Biomarker 4"),
#'   "group 3" = "Biomarker 5")
#'
#' compile_biomarker_groups_table(
#'    dataset = sim_data,
#'    biomarker_group_list = biomarker_group_list)
#'
compile_biomarker_groups_table <- function(
    dataset,
    biomarker_group_list =
      compile_biomarker_group_list(dataset = dataset, ...),
    colors =
      biomarker_group_list |>
      choose_biomarker_group_colors(),
    ...)
{
  to_return =
    biomarker_group_list |>
    stack() |>
    as_tibble() |>
    dplyr::rename(
      biomarker  = values,
      biomarker_group = ind)  |>
    dplyr::mutate(
      biomarker_group =
        biomarker_group |>
        factor(levels = names(biomarker_group_list))) |>
    left_join(
      colors,
      by = "biomarker_group"
    )

  labels1 <-
    dataset |>
    dplyr::select(all_of(to_return$biomarker)) |>
    labelled::get_variable_labels() |>
    unlist()

  labels2 = swap_names_and_values(labels1)

  if(!is.null(labels2))
  {
    to_return =
      to_return |>
      labelled::add_value_labels(biomarker = labels2)
  }

  to_return
}
