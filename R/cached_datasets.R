#' List cached datasets'
#'
#' When you download a dataset from refine.bio, it is cached locally.
#' This function will list all of the cached datasets.
#'
#' @param datastore_path The path to the local datastore.
#'
#' @return A character vector of cached dataset IDs.
#'
#' @author Sean Davis <seandavi@gmail.com>
#'
#' @examples
#'
#' test_datatore_path <- system.file(
#'   "testdata/datastore",
#'   package = "RefineBio"
#' )
#' list.files(test_datatore_path, recursive = TRUE)
#' datastore_datasets(test_datatore_path)
#'
#' @export
datastore_datasets <- function(base_path = datastore_get_path()) {
  agg_metadata_files <- list.files(
    base_path,
    pattern = "aggregated_metadata.json",
    recursive = TRUE, full.names = TRUE
  )
  return(basename(dirname(agg_metadata_files)))
}
