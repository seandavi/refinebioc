#' Local datastore path settings
#'
#' The refine.bio R package caches downloaded datasets locally.
#'
#' This function returns the path to the local datastore.
#'
#' @family Local datastore operations
#'
#' @return The path to the local datastore.
#'
#' @export
datastore_get_path <- function() {
    datastore_path <- NULL
    if (!is.null(getOption("refinebioc.datastore"))) {
        datastore_path <- getOption("refinebioc.datastore")
    }
    if (Sys.getenv("REFINEBIOC_DATASTORE", "") != "") {
        datastore_path <- Sys.getenv("REFINEBIOC_DATASTORE")
    }
    if (is.null(datastore_path)) {
        datastore_path <- file.path(tempdir(), "rb_datastore")
    }
    if (!dir.exists(datastore_path)) {
        dir.create(datastore_path, recursive = TRUE)
    }
    return(datastore_path)
}
