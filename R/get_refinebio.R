#' Get one or more experiments (GSE, SRP, etc) from RefineBio
#'
#' This is the main function for interacting with RefineBio. It will
#' download, extract, and load the data from RefineBio for the given
#' experiment(s).
#'
#' @param experiment The experiment ID or `rb_experiment` object
#'
#' @author Sean Davis <seandavi.gmail.com>
#'
#' @return A list of `SummarizedExperiment`s representing the
#' experiments in the RefineBio downloaded dataset.
#'
#' @examples
#' \dontrun{
#' # Get a single experiment
#' expt <- rb_get_experiment("GSE1133")
#'
#' # Get multiple experiments
#' expts <- rb_get_experiment(c("GSE1133", "GSE11331"))
#' }
#' @export

get_refinebio <- function(experiment) {
  ds <- submit_dataset_request(
    studies = experiment
  )
  logger::log_info("Registered dataset request: ", ds$id)
  loaded_dataset <- process_and_load_dataset(ds)
  return(loaded_dataset)
}

#' Process and load a dataset
#'
#' This function will process and load a dataset from RefineBio. It is
#' intended for use with the `rb_get_experiment` function.
#'
#' @param ds The dataset ID or `rb_dataset` object
#' @param base_path The path to the directory where the dataset will be
#' downloaded and extracted.
#'
#' @return A list of `SummarizedExperiment`s representing the
#' experiments in the RefineBio downloaded dataset.
#'
#' @export
process_and_load_dataset <- function(ds, base_path = datastore_get_path()) {
  if (is.character(ds)) {
    ds <- list(id = ds)
  }
  logger::log_formatter(logger::formatter_paste)
  logger::log_info("Starting to wait for RefineBio to process: ", ds$id)
  wait_for_dataset(ds)
  logger::log_info("RefineBio finished processing: ", ds$id)
  logger::log_info("Dataset available: ", ds$id)
  logger::log_info("Starting to download: ", ds$id)
  download_dataset(ds)
  logger::log_info("Dataset downloaded: ", ds$id)
  logger::log_info("Starting to extract: ", ds$id)
  extract_dataset(ds)
  logger::log_info("Dataset extracted: ", ds$id)
  loaded_dataset <- load_dataset(ds)
  logger::log_info("Dataset loaded: ", ds$id)

  return(loaded_dataset)
}
