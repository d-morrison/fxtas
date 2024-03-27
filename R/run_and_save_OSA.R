#' Run the Ordinal SusTaIn algorithm (OSA) or load results from RDS
#'
#' @inheritParams run_OSA
#' @inheritDotParams run_OSA
#'
#' @returns a [list()]
#' @export
#'
run_and_save_OSA = function(
    dataset_name,
    output_folder,
    verbose = TRUE,
    N_S_max,
    ...)
{

  rds_filebase = glue::glue("{dataset_name}_1-{N_S_max}")
  rds_path = build_rds_path(rds_filebase, output_folder)

  if(file.exists(rds_path))
  {
    if(verbose) cli::cli_inform("Found RDS file for {rds_filebase}; loading...")
    sus_output = readRDS(rds_path)
    testthat::expect_equal(dim(sus_output$samples_sequence)[1], N_S_max)
  } else
  {
    if(verbose) cli::cli_inform("RDS file for {rds_filebase} not found; running OSA.")
    sus_output = run_OSA(
      dataset_name = dataset_name,
      output_folder = output_folder,
      N_S_max = N_S_max,
      verbose = verbose,
      ...
    )
    sus_output |> saveRDS(rds_path)
  }

  return(sus_output)

}
