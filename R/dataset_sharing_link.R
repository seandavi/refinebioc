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
