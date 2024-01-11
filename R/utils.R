#' @title Get absolute path to a file or directory
#'
#' @param path A path to a file or directory
#'
#' @return The absolute path to the file or directory
#'
#' @examples
#' get_absolute_path("~/Documents")
#' get_absolute_path("~")
#' get_absolute_path(datastore_example_path())
#'
#' @export
get_absolute_path <- function(path) {
    path <- normalizePath(path)

    return(file.path(dirname(path), basename(path)))
}
