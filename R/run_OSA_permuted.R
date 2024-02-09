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
    patient_data,
    prob_score0,
    ...)
{
  for (cur_seed in permutation_seeds)
  {
    set.seed(cur_seed)
    permuted_genders = sample(
      x = patient_data$Gender,
      size = nrow(patient_data),
      replace = FALSE)

    sustain_output_males_permuted = run_OSA(
      prob_score = prob_score0[permuted_genders %in% "Male",,],
      dataset_name = paste("males", cur_seed, sep = "_p"),
      ...)

    sustain_output_females_permuted = run_OSA(
      prob_score = prob_score0[permuted_genders %in% "Female",,],
      dataset_name = paste("females", cur_seed, sep = "_p"),
      ...)

  }

  return(NULL)
}
