#' Extract results from pickle file
#'
#' @param n_s helps construct `picklename` by identifying number of latent subgroups
#' @param dataset_name root name of dataset
#' @param output_folder where to find the dataset
#' @param picklename the name of the pickle file to open
#' @param rda_filename name of rda file containing environment used to run analyses
#' @param format_results whether to apply [format_results_list()] to results before returning
#' @inheritDotParams format_results_list format_sst
#' @returns
#' @export
#'
extract_results_from_pickle = function(
    n_s = 1,
    dataset_name = 'sample_data',
    output_folder = "output",
    rda_filename = "data.RData",
    basename = paste0(dataset_name, "_subtype", n_s - 1),
    picklename = paste0(basename, ".pickle"),
    format_results = TRUE,
    ...)
{
  rds_path = build_rds_path(
    dataset_name = basename,
    output_folder = output_folder)

  if(file.exists(rds_path))
  {
    cli::cli_inform("\nloading {basename} results from RDS file:\n{rds_path}\n")
    results = readRDS(rds_path)
  } else
  {
    cli::cli_inform("\nloading {basename} results from pickle file:\n{picklename}\n")
    results00 =
      fs::path(output_folder, "pickle_files", picklename) |>
      py_load_object() |>
      force()

    biomarker_levels =
      output_folder |>
      fs::path("biomarker_levels.rds") |>
      readr::read_rds()

    if (format_results)
    {
    results =
      results00 |>
      format_results_list(
        biomarker_levels = biomarker_levels,  # these come from the load() call,
        ...
      )

    } else
    {
      results = results00
    }

    results |> saveRDS(file = rds_path)
  }

  return(results)

}

#' Extract results from multiple pickle files
#'
#' @inheritParams extract_results_from_pickle
#' @returns
#' @export
#'
extract_results_from_pickles =
  extract_results_from_pickle |>
  Vectorize(vectorize.args = c("n_s", "picklename"), SIMPLIFY = FALSE)
