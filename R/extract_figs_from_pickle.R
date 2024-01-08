#' @title Extact PVDs from pickle file
#' @inheritParams extract_results_from_pickle
#' @inheritDotParams plot_positional_var
#' @return
#' @export
#'
extract_figs_from_pickle = function(
    n_s = 1,
    dataset_name = 'sample_data',
    output_folder = "output",
    rda_filename = "data.RData",
    picklename = paste0(dataset_name, "_subtype", n_s - 1, ".pickle"),
    ...)
{

  results =
    fs::path(output_folder, "pickle_files", picklename) |>
    py_load_object() |>
    force()

  load(fs::path(output_folder, rda_filename))

  figs = plot_positional_var(
    results = results,
    score_vals = score_vals, # these come from the load() call
    biomarker_groups = biomarker_groups, # these come from the load() call
    biomarker_levels = biomarker_levels, # these come from the load() call
    ...)

}
