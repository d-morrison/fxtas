#' @title Run the Ordinal SuStaIn Algorithm (OSA)
#'
#' @param prob_score [array] probability of each score for all subjects across all biomarkers
#'  * dim = number of subjects x number of biomarkers x number of scores
#' @param score_vals a matrix specifying the scores for each biomarker
#'  * dim: number of biomarkers x number of scores
#' @param SuStaInLabels the names of the biomarkers as a list of strings
#' @param N_startpoints number of startpoints to use in maximum likelihood step of SuStaIn, typically 25
#' @param N_S_max maximum number of subtypes, should be 1 or more
#' @param N_iterations_MCMC number of MCMC iterations, typically 1e5 or 1e6 but can be lower for debugging
#' @param output_folder where to save pickle files, etc.
#' @param dataset_name for naming pickle files
#' @param use_parallel_startpoints boolean for whether or not to parallelize the maximum likelihood loop
#' @param seed random number seed for python code
#' @param plot [logical()] indicating whether to construct PVD plots via python subroutines
#' @param N_CV_folds number of cross-validation folds to create
#' @param patient_data patient biomarker data
#' @param CV_fold_nums which CV folds to run (for parallel processing)
#' @param verbose [logical()] indicating whether to print debugging information
#'
#' @returns a [list()]
#' @export
#'
run_OSA = function(
    prob_score,
    score_vals,
    SuStaInLabels,
    N_startpoints,
    N_S_max,
    N_iterations_MCMC = 1e5L,
    output_folder,
    dataset_name,
    use_parallel_startpoints = FALSE,
    seed = 1L,
    plot = FALSE,
    N_CV_folds = 0,
    CV_fold_nums = 1:N_CV_folds,
    patient_data,
    verbose = TRUE)
{

  if(verbose) message("starting `run_OSA()`")

  # reticulate::use_virtualenv("r-pySuStaIn")
  # pySuStaIn = reticulate::import("pySuStaIn")
  sustain_input = pySuStaIn$OrdinalSustain(
    prob_nl = prob_score[,,1],
    prob_score = prob_score[,,-1, drop = FALSE],
    score_vals = score_vals,
    biomarker_labels = SuStaInLabels,
    N_startpoints = N_startpoints,
    N_S_max = N_S_max |> as.integer(), # double doesn't work
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
    sklearn = reticulate::import("sklearn")
    cv =
      sklearn$
      model_selection$
      StratifiedKFold(
        n_splits = N_CV_folds |> as.integer(),
        shuffle = TRUE,
        random_state = seed |> as.integer())

    cv_it = cv$split(patient_data, labels)

    splits =
      reticulate::iterate(cv_it) |>
      lapply(F = function(x) x[[2]] |> as.integer())

    # R version of random partitioning
    # (haven't figured out stratification yet, although it's not needed currently)
    # split2 = splitTools::create_folds(
    #   y = patient_data[,1],
    #   k = N_CV_folds,
    #   seed = seed,
    #   invert = TRUE
    # )

    if(verbose)
    {
      message('Starting cross-validation of ', dataset_name)
      message("here are the current folds: ")
      print(splits)
      message('folds to run: ', paste(CV_fold_nums, collapse = ', '))
    }


    CV_output =
      sustain_input$
      cross_validate_sustain_model(
        test_idxs = splits,
        select_fold = as.integer(CV_fold_nums - 1L))

    names(CV_output) = c("CVIC", "loglike_matrix")
    sus_output |> attr("CV") = CV_output
  }

  return(sus_output)
}
