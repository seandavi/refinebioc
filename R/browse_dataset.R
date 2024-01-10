#' Get a sharing link for the given dataset
#'
#' This function will return a sharing link for the given dataset.
#' The link can be used to share the dataset with others.
#'
#' @param dataset The dataset ID or `rb_dataset` object
#'
#' @return A sharing link for the given dataset
#'
#' @author Sean Davis <seandavi@gmail.com>
#'
#' @examples
#' \dontrun{
#' dataset_sharing_link(dataset)
#' }
#'
#' @export
dataset_sharing_link <- function(dataset) {
  dataset_id <- .dataset_id_from_args(dataset)
  return(sprintf("https://www.refine.bio/dataset/%s?ref=share", dataset_id))
}

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
#' @return the dataset page URL (invisibly)
#'
#' @examples
#' \dontrun{
#' dataset_page_browser(dataset)
#' }
#'
#' @export
dataset_page_browser <- function(dataset) {
  dataset_id <- .dataset_id_from_args(dataset)
  if (interactive() && !Sys.getenv("TESTTHAT") == "true") {
    browseURL(sprintf("https://www.refine.bio/dataset/%s", dataset_id))
  }
  invisible(sprintf("https://www.refine.bio/dataset/%s", dataset_id))
}
