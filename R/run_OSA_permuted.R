#' Randomly permute some some variables and run the OSA model on the permuted data
#'
#' @param permutation_seeds random number generator seeds to use to permute the data
#' @param permuting_variables which variables to permute
#' @inheritParams run_OSA
#' @inheritDotParams run_OSA
#'
#' @returns [NULL], invisibly (.pickle and .rds files are generated to save the output)
#' @export
#'
run_OSA_permuted = function(
    permutation_seeds = 1:100,
    permuting_variables = "Gender",
    patient_data,
    ...)
{
  for (cur_seed in permutation_seeds)
  {
    set.seed(cur_seed)
    permuted_data =
      patient_data |>
      mutate(
        across(
          all_of(permuting_variables),
          ~sample(.x, size = nrow(patient_data), replace = FALSE)))

    permuted_variable_combinations =
      patient_data |> distinct(across(all_of(permuting_variables)))

    for (cur_level in 1:nrow(permuted_variable_combinations))
    {
      message('current permuted group being analyzed:')
      print(permuted_variable_combinations[cur_level,])

      data_to_use =
        permuted_data |>
        semi_join(
          permuted_variable_combinations[cur_level,],
          by = permuting_variables)

      cur_dataset_name =
        permuted_variable_combinations[cur_level,] |>
        sapply(F = as.character) |>
        paste(collapse = " - ") |>
        paste(cur_seed, sep = "_p")

      run_and_save_OSA(
        patient_data = data_to_use,
        dataset_name = cur_dataset_name,
        ...)
    }

  }

  return(invisible(NULL))
}
