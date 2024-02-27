#' Collect permutation test statistics
#'
#' @param output_folder
#' @param permutation_results
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' test_stats = collect_permutation_test_stats("output/output.fixed_CV")
#' }
collect_permutation_test_stats = function(
    output_folder = fs::path(here::here(), "output/output.fixed_CV"),
    permutation_results = output_folder |> fs::path("permutation_test_stats"))
{

  test_stats = c()
  files = dir(permutation_results, full = TRUE)
  for (cur_file in files)
  {
    permuted_test_stats = readRDS(cur_file)
    test_stats = test_stats |> c(permuted_test_stats)
  }

  return(test_stats)
}
