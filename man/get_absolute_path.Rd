% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{get_absolute_path}
\alias{get_absolute_path}
\title{Get absolute path to a file or directory}
\usage{
get_absolute_path(path)
}
\arguments{
\item{path}{A path to a file or directory}
}
\value{
The absolute path to the file or directory
}
\description{
Get absolute path to a file or directory
}
\examples{
get_absolute_path("~/Documents")
get_absolute_path("~")
get_absolute_path(datastore_example_path())

}
