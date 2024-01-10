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
  if (!missing(datastore_path)) {
    options(refinebioc.datastore = datastore_path)
  } else {
    datastore_path <- file.path(tempdir(), "rb_datastore")
  }
  if (!is.null(getOption("refinebioc.datastore"))) {
    datastore_path <- getOption("refinebioc.datastore")
  }
  if (Sys.getenv("REFINEBIOC_DATASTORE", "") != "") {
    datastore_path <- Sys.getenv("REFINEBIOC_DATASTORE")
  }
  if (!dir.exists(datastore_path)) {
    dir.create(datastore_path, recursive = TRUE)
  }
  return(datastore_path)
}


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

rb_email_address <- function() {
  return(whoami::email_address())
}
