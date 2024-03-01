#' Title
#'
#' @param permutation_seeds
#' @param patient_data
#' @param prob_score0
#' @param ...
#'
#' @return
#' @export
#'
run_OSA_permuted = function(
    permutation_seeds = 1:100,
    permuting_variables = "Gender",
    patient_data,
    prob_score0,
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

      run_OSA(
          prob_score = prob_score0[data_to_use[["FXS ID"]],,],
          dataset_name =
            permuted_variable_combinations[cur_level,] |>
            sapply(F = as.character) |>
            paste(collapse = " - ") |>
            paste(cur_seed, sep = "_p"),
          ...)
    }

  }

  return(NULL)
}
