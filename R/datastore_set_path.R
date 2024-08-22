#' Set the path to the refine.bio datastore
#'
#' The refine.bio R package caches downloaded datasets locally.
#'
#' This function sets the path to the local datastore.
#'
#' Order of precedence:
#' 1. `datastore_path` argument
#' 2. `refinebioc.datastore` option
#' 3. `REFINEBIOC_DATASTORE` environment variable
#'
#' @param path `character(1)`
#'  The path to the local datastore.
#'
#' @return `character(1)`
#'  The path to the local datastore.
#'
#' @family Local datastore operations
#'
#' @export
datastore_set_path <- function(path) {
    stopifnot(is.character(path))
    stopifnot(length(path) == 1)

    if (!dir.exists(path)) {
        dir.create(path, recursive = TRUE)
    }
    options(refinebioc.datastore = path)
    invisible(path)
}
