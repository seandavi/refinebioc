#   This set of functions will build a list of Summarized Experiments when given
#   a main path folder from the RefineBio download.



#' load a list of `SummarizedExperiment`s from an extracted RefineBio download
#'
#' The download directory from RefineBio is a zip file containing a folder of
#' experiments. This function will load the experiments from the extracted
#' zip file and return a list of `SummarizedExperiment`s. In the case of a
#' single experiment, the list will contain a single element.
#'
#' The returned list will be named based on the experiment ids in the download.
#'
#' @param basedir Path to the directory of an extracted RefineBio download.
#'
#' @author Alexander Ho and Sean Davis
#'
#' @return A list of `SummarizedExperiment`s representing the
#'   experiments in the RefineBio downloaded dataset.
#'
#' @examples
#' # load the SummarizedExperiment package
#' # We'll need it later.
#' suppressPackageStartupMessages(library(SummarizedExperiment))
#'
#' # use an example datastore
#' datastore_path <- datastore_example_path()
#'
#' # Get the first dataset from the datastore
#' example_dataset <- datastore_datasets(datastore_path)[1]
#'
#' # Get the path to the dataset
#' example_dataset_path <- file.path(datastore_path, example_dataset)
#'
#' # Load the dataset
#' example_se_list <- extract_local_dataset(example_dataset_path)
#'
#' # Get the first experiment
#' example_se <- example_se_list[[1]]
#'
#' example_se
#'
#' # Get the first experiment's metadata
#' str(metadata(example_se))
#'
#' @export
extract_local_dataset <- function(basedir) {
  # Load the metadata file.
  md_filename_regex <- "aggregated_metadata.json"
  md_filename <- list.files(basedir, pattern = md_filename_regex)
  if (length(md_filename) != 1) {
    stop("Could not find metadata file in download directory.")
  }
  md_file <- file.path(basedir, md_filename)
  md <- jsonlite::read_json(
    md_file,
    simplifyDataFrame = TRUE, simplifyVector = TRUE
  )

  # Load the experiment files.

  selist <- lapply(names(md$experiments), function(exptname) {
    # Prep the metadata for attachment to the SummarizedExperiment.
    expt_metadata <- md$experiments[[exptname]]
    expt_metadata$sample_accession_codes <- NULL


    # localize to a single folder in the download directory.
    expt_dir <- file.path(basedir, exptname)

    # The metadata_...tsv file contains the colData for the data in
    # the experiment.
    meta_tsv_file <- list.files(
      expt_dir,
      pattern = sprintf("^metadata_%s.tsv", exptname),
      full.names = TRUE,
      recursive = TRUE
    )
    if (length(meta_tsv_file) != 1) {
      stop("Could not find metadata file in download directory.")
    }
    meta_tsv <- data.table::fread(meta_tsv_file)

    # The other tsv file contains the data for the experiment.
    data_tsv_file <- list.files(
      expt_dir,
      pattern = sprintf("^%s.tsv", exptname),
      full.names = TRUE,
      recursive = TRUE
    )
    if (length(data_tsv_file) != 1) {
      stop("Could not find data file in download directory.")
    }
    data_tsv <- data.table::fread(data_tsv_file)

    # Prepare the data matrix for attachment to the SummarizedExperiment in
    # the assay list.
    data_matrix <- as.matrix(data_tsv[, -1])

    # fix the coldata to have the correct names, etc.
    rownames(meta_tsv) <- colnames(data_matrix)

    # Finally, create and return the SummarizedExperiment.
    SummarizedExperiment::SummarizedExperiment(
      colData = meta_tsv,
      assays = list(exprs = data_matrix),
      rowData = data.frame(Gene = data_tsv$Gene),
      metadata = expt_metadata
    )
  })
  stats::setNames(selist, names(md$experiments))
}
