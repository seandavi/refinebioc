% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/field_metadata.R
\name{rb_entity_list}
\alias{rb_entity_list}
\title{Helper function for getting entity lists}
\usage{
rb_entity_list(endpoint, paginate)
}
\arguments{
\item{endpoint}{\code{character(1)} The endpoint to get data from.}

\item{paginate}{\code{logical(1)} Whether to paginate through the results.}
}
\value{
\code{data.frame} The results of the query.
}
\description{
Helper function for getting entity lists
}
\examples{
\dontrun{
rb_entity_list("platforms", paginate = FALSE)
}
}
\seealso{
Other refine.bio API: 
\code{\link{rb_compendia_list}()},
\code{\link{rb_institution_list}()},
\code{\link{rb_organism_list}()},
\code{\link{rb_platform_list}()}
}
\author{
Sean Davis \href{mailto:seandavi@gmail.com}{seandavi@gmail.com}
}
\concept{refine.bio API}
\keyword{internal}
