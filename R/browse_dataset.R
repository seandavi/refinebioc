#' Open a webpage for the given dataset
#'
#' This function will open a browser window to the RefineBio dataset page
#' for the given dataset. This is a convenience function for users who
#' want to quickly view the dataset page for a given dataset.
#'
#' @param dataset The dataset ID or `rb_dataset` object
#'
#' @author Sean Davis <seandavi@gmail.com>
#'
#' @export
rb_browse_dataset <- function(dataset) {
  dataset_id <- .dataset_id_from_args(dataset)
  browseURL(sprintf("https://www.refine.bio/dataset/%s", dataset_id))
}
