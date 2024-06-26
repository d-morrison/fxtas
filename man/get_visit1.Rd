% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_visit1.R
\name{get_visit1}
\alias{get_visit1}
\title{Get each participant's first visit in dataset}
\usage{
get_visit1(dataset)
}
\arguments{
\item{dataset}{a \link[tibble:tbl]{tibble::tbl} containing the following columns:
\itemize{
\item \verb{FXS ID}: participant ID number (\code{\link[=character]{character()}})
\item \verb{Visit Date}: date of clinic visit (\code{\link[=Date]{Date()}})
\item \verb{Event Name}: role of clinic visit in the study design (\code{\link[=character]{character()}})
}}
}
\value{
a \link[tibble:tbl]{tibble::tbl}
}
\description{
Get each participant's first visit in dataset
}
\examples{
gp34 |> get_visit1()
}
