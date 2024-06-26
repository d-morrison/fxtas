% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_and_save_OSA.R
\name{run_and_save_OSA}
\alias{run_and_save_OSA}
\title{Run the Ordinal SusTaIn algorithm (OSA) or load results from presaved .rds file if available}
\usage{
run_and_save_OSA(
  dataset_name,
  output_folder,
  verbose = TRUE,
  N_S_max,
  rerun = FALSE,
  rda_filename = "data.RData",
  ...
)
}
\arguments{
\item{dataset_name}{for naming pickle files}

\item{output_folder}{where to save pickle files, etc.}

\item{verbose}{\code{\link[=logical]{logical()}} indicating whether to print debugging information}

\item{N_S_max}{maximum number of subtypes, should be 1 or more}

\item{...}{
  Arguments passed on to \code{\link[=run_OSA]{run_OSA}}
  \describe{
    \item{\code{prob_score}}{\link{array} probability of each score for all subjects across all biomarkers
\itemize{
\item dim = number of subjects x number of biomarkers x number of scores
}}
    \item{\code{score_vals}}{a matrix specifying the scores for each biomarker
\itemize{
\item dim: number of biomarkers x number of scores
}}
    \item{\code{SuStaInLabels}}{the names of the biomarkers as a list of strings}
    \item{\code{N_startpoints}}{number of startpoints to use in maximum likelihood step of SuStaIn, typically 25}
    \item{\code{N_iterations_MCMC}}{number of MCMC iterations, typically 1e5 or 1e6 but can be lower for debugging}
    \item{\code{use_parallel_startpoints}}{boolean for whether or not to parallelize the maximum likelihood loop}
    \item{\code{seed}}{random number seed for python code}
    \item{\code{plot}}{\code{\link[=logical]{logical()}} indicating whether to construct PVD plots via python subroutines}
    \item{\code{N_CV_folds}}{number of cross-validation folds to create}
    \item{\code{patient_data}}{patient biomarker data}
    \item{\code{CV_fold_nums}}{which CV folds to run (for parallel processing)}
    \item{\code{keep_data}}{\code{\link[=logical]{logical()}} indicating whether to include the ata in the return object}
    \item{\code{fig_size}}{python figure size, in inches (width, height)}
    \item{\code{prob_correct}}{the probability of correctly classifying the underlying biomarker level: p(obs = true)}
    \item{\code{biomarker_levels}}{a list containing the levels for each biomarker}
  }}
}
\value{
a \code{\link[=list]{list()}}
}
\description{
Run the Ordinal SusTaIn algorithm (OSA) or load results from presaved .rds file if available
}
