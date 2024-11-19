#' @title Extact PVDs from pickle file
#' @inheritParams extract_results_from_pickle
#' @inheritDotParams plot_positional_var
#' @inherit plot_positional_var return
#' @export
#' @examples
#' figs = extract_figs_from_pickle(
#'   output_folder = "output/SuStaIn-simulated-data",
#'   n = 3)
#'
extract_figs_from_pickle = function(
    n_s = 1,
    dataset_name = 'sample_data',
    output_folder = "output",
    rda_filename = "data.RData",
    picklename = paste0(dataset_name, "_subtype", n_s - 1, ".pickle"),
    use_rds = TRUE,
    ...)
{

  results = extract_results_from_pickle(
    n_s = n_s,
    dataset_name = dataset_name,
    output_folder = output_folder,
    rda_filename = rda_filename,
    picklename = picklename,
    use_rds = use_rds)

  biomarker_groups =
    output_folder |>
    fs::path("biomarker_groups.rds") |>
    readr::read_rds()

  biomarker_levels =
    output_folder |>
    fs::path("biomarker_levels.rds") |>
    readr::read_rds()

  plot_positional_var(
    results = results,
    biomarker_groups = biomarker_groups,
    biomarker_levels = biomarker_levels,
    ...)

}
