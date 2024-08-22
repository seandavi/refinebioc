#' An example datastore
#'
#' This is a small datastore that is used for testing.
#'
#' @family Local datastore operations
#'
#' @export
datastore_example_path <- function() {
  return(system.file("testdata/datastore", package = "refinebioc"))
}
