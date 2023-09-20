#' Title
#'
#' @param prob_score
#' @param score_vals
#' @param SuStaInLabels
#' @param N_startpoints
#' @param N_S_max
#' @param N_iterations_MCMC
#' @param output_folder
#' @param dataset_name
#' @param use_parallel_startpoints
#' @param seed
#' @param plot
#'
#' @return
#' @export
#'
run_SSA = function(
    prob_score,
    score_vals,
    SuStaInLabels,
    N_startpoints,
    N_S_max,
    N_iterations_MCMC,
    output_folder,
    dataset_name,
    use_parallel_startpoints = FALSE,
    seed = 1,
    plot = FALSE)
{
  pySuStaIn = import("pySuStaIn")
  sustain_input = pySuStaIn$OrdinalSustain(
    prob_nl = prob_score[,,1],
    prob_score = prob_score[,,-1, drop = FALSE],
    score_vals = score_vals,
    SuStaInLabels = SuStaInLabels,
    N_startpoints = N_startpoints,
    N_S_max = N_S_max,
    N_iterations_MCMC = N_iterations_MCMC,
    output_folder = output_folder,
    dataset_name = dataset_name,
    use_parallel_startpoints = use_parallel_startpoints,
    seed = seed)

  sus_output = sustain_input$run_sustain_algorithm(plot= plot)
  names(sus_output) = c(
    "samples_sequence",
    "samples_f",
    "ml_subtype",
    "prob_ml_subtype",
    "ml_stage",
    "prob_ml_stage",
    "prob_subtype_stage",
    "samples_likelihoods",
    "fig0"
  )

  return(sus_output)
}
