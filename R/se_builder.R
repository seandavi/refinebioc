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
#' @param base_path Path to the directory of an extracted RefineBio download.
#'
#' @author Alexander Ho and Sean Davis
#' @keywords internal
dataset_loader <- function(basedir) {
  # Load the metadata file.
  md_filename <- "aggregated_metadata.json"
  md_file <- file.path(basedir, md_filename)
  md <- jsonlite::read_json(md_file, simplifyDataFrame = TRUE)
  md

  # Load the experiment files.

  selist <- lapply(names(md$experiments), function(exptname) {
    # Prep the metadata for attachment to the SummarizedExperiment.
    expt_metadata <- md$experiments[[exptname]]
    md$experiments <- NULL
    md$experiment_details <- expt_metadata

    # localize to a single folder in the download directory.
    expt_dir <- file.path(basedir, exptname)

    # The metadata_...tsv file contains the colData for the data in
    # the experiment.
    meta_tsv_file <- file.path(expt_dir, sprintf("metadata_%s.tsv", exptname))
    meta_tsv <- data.table::fread(meta_tsv_file)

    # The other tsv file contains the data for the experiment.
    data_tsv_file <- file.path(expt_dir, sprintf("%s.tsv", exptname))
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
      metadata = md
    )
  })
  setNames(selist, names(md$experiments))
}
