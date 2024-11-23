#' Find path to RDS file with output
#'
#' @param dataset_name [character()]
#' @param output_folder [character()]
#'
#' @returns a [character()] variable
#' @export
#'
#' @examples
#' build_rds_path("sample_data", "output.fixed_CV")
build_rds_path <- function(dataset_name, output_folder)
{
  rds_filename = paste0(dataset_name, ".rds")

  rds_folder_path =
    fs::path(
      output_folder,
      "rds_files"
    ) |>
    fs::dir_create()

  rds_path = fs::path(rds_folder_path, rds_filename)
}
