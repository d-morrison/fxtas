% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_results_list.R
\name{format_results_list}
\alias{format_results_list}
\title{Format results list extracted from pickle file}
\usage{
format_results_list(
  results,
  biomarker_labels = names(biomarker_levels),
  biomarker_levels = NULL,
  biomarker_events_table = get_biomarker_events_table(biomarker_levels),
  biomarker_event_names = pull(biomarker_events_table, biomarker_level),
  format_sst = TRUE
)
}
\arguments{
\item{results}{pickle file contents}

\item{biomarker_labels}{biomarker labels}

\item{biomarker_levels}{biomarker levels}

\item{biomarker_events_table}{table of biomarker events (excluding base level)}

\item{biomarker_event_names}{vector of biomarker event names}

\item{format_sst}{should the subtype and stage table be formatted? (doesn't work for cross-validation fold pickle-files)}
}
\value{
a \code{"SuStaIn-model"} object (extends \code{\link[=list]{list()}})
}
\description{
Format results list extracted from pickle file
}
