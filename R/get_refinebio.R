#' Get one or more experiments (GSE, SRP, etc) from RefineBio
#'
#' This is the main function for interacting with RefineBio. It will
#' download, extract, and load the data from RefineBio for the given
#' experiment(s).
#'
#' @param experiment character() vector of experiment IDs (e.g., GSE1133)s
#' @param quantile_normalize logical Should the data be quantile normalized?
#' Default is FALSE. If TRUE, the data will be quantile normalized based on
#' the distribution of all data for a species.
#' @param svd_algorithm character Which SVD algorithm to use? One of
#' "NONE", "RANDOMIZED", "ARPACK"
#' @param scale_by character How to scale the data? One of "NONE", "MINMAX",
#' "STANDARD", "ROBUST"
#' @param aggregate_by character How to aggregate the data? One of
#' "EXPERIMENT", "SPECIES", "ALL"
#'
#' @author Sean Davis <seandavi.gmail.com>
#'
#' @return A list of `SummarizedExperiment`s representing the
#' experiments in the RefineBio downloaded dataset.
#'
#' @examples
#' \dontrun{
#' # Get a single experiment
#' expt <- get_refinebio("GSE116672")
#'
#' # Get multiple experiments
#' expts <- get_refinebio(c("SRP066613", "SRP158666"))
#'
#' # Get multiple experiments with quantile normalization
#' expts <- get_refinebio(
#'   c("SRP066613", "SRP158666"),
#'   quantile_normalize = TRUE
#' )
#' # Get multiple experiments with quantile normalization and
#' # aggregate everything into one summarized experiment
#' expts <- get_refinebio(
#'   c("SRP066613", "SRP158666"),
#'   quantile_normalize = TRUE,
#'   aggregate_by = "ALL"
#' )
#' }
#' @export

get_refinebio <- function(
    experiments,
    quantile_normalize = FALSE,
    svd_algorithm = "NONE",
    scale_by = "NONE",
    aggregate_by = "EXPERIMENT") {
  ds <- submit_dataset_request(
    studies = experiments,
    quantile_normalize = quantile_normalize,
    svd_algorithm = svd_algorithm,
    scale_by = scale_by,
    aggregate_by = aggregate_by
  )
  logger::log_info("Registered dataset request: ", ds$id)
  loaded_dataset <- process_and_load_dataset(ds)
  return(loaded_dataset)
}

#' Process and load a dataset
#'
#' This function will process and load a dataset from RefineBio. It is
#' intended for use with the `rb_get_experiment` function. However,
#' it can be used with any dataset that has been registered by RefineBio.
#' This function will download, extract, and load the data from RefineBio
#' for the given dataset.
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
  logger::log_info("Starting to process at RefineBio: ", ds$id)
  logger::log_info("This may take many minutes, depending on data size.")
  logger::log_info("Wait for RefineBio to process: ", ds$id)
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
