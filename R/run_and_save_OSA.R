#' @title Run the Ordinal SusTaIn algorithm (OSA) or load results from presaved .rds file if available
#' @params rerun whether to force a rerun of the python code
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
    rerun = FALSE,
    rda_filename = "data.RData",
    ...)
{

  rds_filebase = glue::glue("{dataset_name}_1-{N_S_max}")
  rds_path = build_rds_path(rds_filebase, output_folder)

  if(file.exists(rds_path) && !rerun)
  {
    if(verbose) cli::cli_alert_info("Found RDS file for {rds_filebase}; loading...")
    osa_output = readRDS(rds_path)
    testthat::expect_equal(dim(osa_output$samples_sequence)[1], N_S_max)
  } else
  {

    if (verbose)
    {
      if (!file.exists(rds_path))
      {
        cli::cli_alert_info("RDS file for {rds_filebase} not found.")
      }
      if (rerun) cli::cli_alert_info("`rerun = TRUE`.")
    }

    osa_output = run_OSA(
      dataset_name = dataset_name,
      output_folder = output_folder,
      N_S_max = N_S_max,
      verbose = verbose,
      ...
    )
    osa_output |> saveRDS(rds_path)
  }

  temp = extract_results_from_pickles(
    n_s = 1:N_S_max,
    rda_filename = rda_filename,
    dataset_name = dataset_name,
    output_folder = output_folder)

  return(osa_output)

}
