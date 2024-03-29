#' Title
#'
#' @param n_s
#' @param dataset_name
#' @param output_folder
#' @param picklename
#' @param results
#' @param ...
#'
#' @return
#' @export
#'
extract_figs_from_pickle = function(
    n_s = 1,
    dataset_name = 'sample_data',
    output_folder = "output",
    picklename = paste0(dataset_name, "_subtype", n_s - 1, ".pickle"),
    results =
      fs::path(output_folder, "pickle_files", picklename) |>
      py_load_object(),
    ...)
{

  figs = plot_positional_var(
    results = results,
    biomarker_labels = SuStaInLabels,
    ...)

}
