#' Collect permutation test statistics
#'
#' @param output_folder where to find the `permutations/test_stats`
#' subfolder
#' @param permutation_results_folder_path path to folder
#' containing `.rds` files with permuted test statistics
#' @param seeds seeds to find
#' @param by number of seeds per file
#' @param file_stem stem of test stat .rds files
#' @param permuting_variables which variables to permute
#' @param stratifying_levels which variables to stratify by
#'
#' @returns a [numeric] vector
#' @export
#'
#' @examples
#' \dontrun{
#' test_stats = collect_permutation_test_stats("output/output.fixed_CV")
#' }
collect_permutation_test_stats <- function(
    permuting_variables,
    stratifying_levels = "",
    output_folder =
      here::here() |>
      fs::path("output/output.fixed_CV"),
    permutation_results_folder_path =
      fs::path(
        output_folder,
        "permutations",
        stratifying_levels |> fs::path_sanitize() |> paste(collapse = "-"),
        permuting_variables |> fs::path_sanitize() |> paste(collapse = "-"),
        "test_stats"),
    file_stem = "permuted_test_stats",
    seeds = 1:1000,
    by = 20)
{

# ---------------------------------------------------------------

  first_seeds = seq(min(seeds), max(seeds), by = by)
  last_seeds = first_seeds + by - 1

  test_stats = c()
  files = fs::path(
    permutation_results_folder_path,
    glue::glue("{file_stem}{first_seeds}-{last_seeds}.rds"))

  missing_files =
    files |>
    setdiff(dir(permutation_results_folder_path, full = TRUE))

  if(length(missing_files) > 0)
  {
    message('missing files:')
    print(missing_files)
    stop("missing files")
  }

  for (cur_file in files)
  {
    permuted_test_stats = readr::read_rds(cur_file)
    test_stats = test_stats |> c(permuted_test_stats)
  }

  return(test_stats)
}
