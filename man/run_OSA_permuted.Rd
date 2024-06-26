% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_OSA_permuted.R
\name{run_OSA_permuted}
\alias{run_OSA_permuted}
\title{Randomly permute some some variables and run the OSA model on the permuted data}
\usage{
run_OSA_permuted(
  permutation_seeds = 1:100,
  permuting_variables = "Gender",
  patient_data,
  ...
)
}
\arguments{
\item{permutation_seeds}{random number generator seeds to use to permute the data}

\item{permuting_variables}{which variables to permute}

\item{patient_data}{patient biomarker data}

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
    \item{\code{N_S_max}}{maximum number of subtypes, should be 1 or more}
    \item{\code{N_iterations_MCMC}}{number of MCMC iterations, typically 1e5 or 1e6 but can be lower for debugging}
    \item{\code{output_folder}}{where to save pickle files, etc.}
    \item{\code{dataset_name}}{for naming pickle files}
    \item{\code{use_parallel_startpoints}}{boolean for whether or not to parallelize the maximum likelihood loop}
    \item{\code{seed}}{random number seed for python code}
    \item{\code{plot}}{\code{\link[=logical]{logical()}} indicating whether to construct PVD plots via python subroutines}
    \item{\code{N_CV_folds}}{number of cross-validation folds to create}
    \item{\code{CV_fold_nums}}{which CV folds to run (for parallel processing)}
    \item{\code{verbose}}{\code{\link[=logical]{logical()}} indicating whether to print debugging information}
    \item{\code{keep_data}}{\code{\link[=logical]{logical()}} indicating whether to include the ata in the return object}
    \item{\code{fig_size}}{python figure size, in inches (width, height)}
    \item{\code{prob_correct}}{the probability of correctly classifying the underlying biomarker level: p(obs = true)}
    \item{\code{biomarker_levels}}{a list containing the levels for each biomarker}
  }}
}
\value{
\link{NULL}, invisibly (.pickle and .rds files are generated to save the output)
}
\description{
Randomly permute some some variables and run the OSA model on the permuted data
}
