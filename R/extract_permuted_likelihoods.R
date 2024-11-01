#' Extract permuted log-likelihoods from pickle files
#'
#' @param permuting_variables which files were permuted
#' @param n_permutations how many permutations were performed
#' @param permutations which permutation seeds to extract
#' @param output_folder where to find the pickle files
#' @param verbose whether to print informative messages about progress
#'
#' @returns a named [numeric()] vector of log-likelihoods from permuted data
#' @export
#'
extract_permuted_likelihoods = function(
    permuting_variables = "Gender",
    n_permutations = 1000,
    permutations = 1:n_permutations,
    output_folder,
    verbose = TRUE
)
{

  permuted_test_stats =
    numeric(length = length(permutations)) |>
    magrittr::set_names(permutations |> as.character())

  file_path = fs::path(output_folder, "data.rds")
  patient_data = readr::read_rds(file = file_path)

  levels =
    patient_data |>
    dplyr::pull(all_of(permuting_variables)) |>
    unique() |>
    as.character()

  if(verbose)
  {
    message('\nlevels are:')
    print(levels)
    message('\npermutations are: ')
    print(permutations)
  }

  for (p in permutations)
  {
    if(verbose) message('analyzing permutation ', p)

    cur_test_stat = 0

    for (cur_level in levels)
    {
      if(verbose)
      {
        message('cur level = ', cur_level)
        message('extracting results from pickle at ', Sys.time())
      }

      results_cur_level = extract_results_from_pickle(
        n_s = 1,
        rda_filename = "data.RData",
        dataset_name = paste(cur_level, p, sep = "_p"),
        output_folder = output_folder)


      llik_cur_level = results_cur_level$samples_likelihood

      cur_test_stat = cur_test_stat + mean(llik_cur_level)
    }

    permuted_test_stats[as.character(p)] = cur_test_stat

  }

  return(permuted_test_stats)

}
