#' Extract results from pickle file
#'
#' @param n_s helps construct `picklename` by identifying number of latent subgroups
#' @param dataset_name root name of dataset
#' @param output_folder where to find the dataset
#' @param picklename the name of the pickle file to open
#' @param rda_filename name of rda file containing environment used to run analyses
#' @inheritDotParams format_results_list format_sst
#' @returns
#' @export
#'
extract_results_from_pickle = function(
    n_s = 1,
    dataset_name = 'sample_data',
    output_folder = "output",
    rda_filename = "data.RData",
    picklename = paste0(dataset_name, "_subtype", n_s - 1, ".pickle"),
    ...)
{

  results00 =
    fs::path(output_folder, "pickle_files", picklename) |>
    py_load_object() |>
    force()

  load(fs::path(output_folder, rda_filename))  # be careful; might mask `results`

  results =
    results00 |>
    format_results_list(
      biomarker_groups = biomarker_groups, # these come from the load() call
      biomarker_levels = biomarker_levels,  # these come from the load() call,
      ...
    )

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
