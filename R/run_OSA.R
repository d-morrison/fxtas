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
#' @param N_CV_folds
#' @param patient_data
#'
#' @return
#' @export
#'
run_OSA = function(
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
    plot = FALSE,
    N_CV_folds = 0,
    CV_fold_nums = 1:N_CV_folds,
    patient_data)
{
  pySuStaIn = reticulate::import("pySuStaIn")
  sustain_input = pySuStaIn$OrdinalSustain(
    prob_nl = prob_score[,,1],
    prob_score = prob_score[,,-1, drop = FALSE],
    score_vals = score_vals,
    biomarker_labels = SuStaInLabels,
    N_startpoints = N_startpoints,
    N_S_max = N_S_max,
    N_iterations_MCMC = N_iterations_MCMC,
    output_folder = output_folder,
    dataset_name = dataset_name,
    use_parallel_startpoints = use_parallel_startpoints,
    seed = seed)

  sus_output = sustain_input$run_sustain_algorithm(plot = plot)
  names(sus_output) = c(
    "samples_sequence",
    "samples_f",
    "ml_subtype",
    "prob_ml_subtype",
    "ml_stage",
    "prob_ml_stage",
    "prob_subtype_stage",
    "samples_likelihoods"
  )

  if(N_CV_folds > 0)
  {

    # generate stratified cross-validation training and test set splits
    labels = patient_data |> pull(Diagnosis)
    sklearn = import("sklearn")
    cv = sklearn$model_selection$StratifiedKFold(
      n_splits= N_CV_folds |> as.integer(),
      shuffle=TRUE)
    cv_it = cv$split(patient_data, labels)

    splits = iterate(cv_it) |> lapply(F = function(x) x[[2]] |> as.integer())

    CV_output = sustain_input$cross_validate_sustain_model(
      test_idxs = splits,
      select_fold = CV_fold_nums)
    names(CV_output) = c("CVIC", "loglike_matrix")
    sus_output |> attr("CV") = CV_output
  }

  return(sus_output)
}
