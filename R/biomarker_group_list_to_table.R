#' Title
#'
#' @param biomarker_group_list
#'
#' @return
#' @export
#'
biomarker_group_list_to_table = function(biomarker_group_list)
{
  biomarker_group_list |>
  stack() |>
    as_tibble() |>
    rename(
      biomarker  = values,
      biomarker_group = ind)
}
