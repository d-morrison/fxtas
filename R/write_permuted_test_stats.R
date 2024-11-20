#' Write permuted test stats as RDS
#'
#' @param permuted_test_stats a named [numeric()] vector of permuted test statistics
#' @param permutations the vector of permutation seeds used to generate `permuted_test_stats`
#' @param output_folder where to create a `test_stats` folder and save `permuted_test_stats` as an .rds file
#' @inheritParams extract_permuted_likelihoods
#' @returns NULL
#' @export
#'
write_permuted_test_stats <- function(
    permuted_test_stats,
    permutations = names(permuted_test_stats),
    output_folder,
    verbose = TRUE
)
{
  file_name =
    paste0(
      "permuted_test_stats",
      permutations[1],
      "-",
      tail(permutations, 1),
      ".rds")

  file_path =
    fs::path(
      output_folder,
      "test_stats") |>
    fs::dir_create() |>
    fs::path(file_name)

  if(verbose) {
    message("file_path:\n", file_path)
    message("permuted_test_stats = \n")
    print(permuted_test_stats)
  }

  if(file.exists(file_path)) file.remove(file_path)

  permuted_test_stats |> saveRDS(file = file_path)

  return(NULL)
}
