% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_refinebio.R
\name{get_refinebio}
\alias{get_refinebio}
\title{Get one or more experiments (GSE, SRP, etc) from RefineBio}
\usage{
get_refinebio(
  experiments,
  quantile_normalize = FALSE,
  svd_algorithm = "NONE",
  scale_by = "NONE",
  aggregate_by = "EXPERIMENT"
)
}
\arguments{
\item{quantile_normalize}{logical Should the data be quantile normalized?
Default is FALSE. If TRUE, the data will be quantile normalized based on
the distribution of all data for a species.}

\item{svd_algorithm}{character Which SVD algorithm to use? One of
"NONE", "RANDOMIZED", "ARPACK"}

\item{scale_by}{character How to scale the data? One of "NONE", "MINMAX",
"STANDARD", "ROBUST"}

\item{aggregate_by}{character How to aggregate the data? One of
"EXPERIMENT", "SPECIES", "ALL"}

\item{experiment}{character() vector of experiment IDs (e.g., GSE1133)s}
}
\value{
A list of \code{SummarizedExperiment}s representing the
experiments in the RefineBio downloaded dataset.
}
\description{
This is the main function for interacting with RefineBio. It will
download, extract, and load the data from RefineBio for the given
experiment(s).
}
\examples{
\dontrun{
# Get a single experiment
expt <- get_refinebio("GSE116672")

# Get multiple experiments
expts <- get_refinebio(c("SRP066613", "SRP158666"))

# Get multiple experiments with quantile normalization
expts <- get_refinebio(
  c("SRP066613", "SRP158666"),
  quantile_normalize = TRUE
)
# Get multiple experiments with quantile normalization and
# aggregate everything into one summarized experiment
expts <- get_refinebio(
  c("SRP066613", "SRP158666"),
  quantile_normalize = TRUE,
  aggregate_by = "ALL"
)
}
}
\author{
Sean Davis <seandavi.gmail.com>
}
