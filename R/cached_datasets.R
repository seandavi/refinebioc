#' List cached datasets'
#'
#' When you download a dataset from refine.bio, it is cached locally.
#' This function will list all of the cached datasets.
#'
#' @param base_path The path to the directory where the datasets are cached.
#'
#' @return A character vector of cached dataset IDs.
#'
#' @author Sean Davis <seandavi@gmail.com>
#'
#' @export
rb_cached_datasets <- function(base_path = rb_data_path()) {
  agg_metadata_files <- list.files(
    base_path,
    pattern = "aggregated_metadata.json",
    recursive = TRUE, full.names = TRUE
  )
  return(basename(dirname(agg_metadata_files)))
}
