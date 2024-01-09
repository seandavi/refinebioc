#' Search for experiments
#'
#' @examples
#' experiments <- rb_experiment_search(
#'   search = "(pediatric) AND (medulloblastoma)",
#' )
#'
#' head(experiments)
#'
#' @export
rb_experiment_search <- function(
    id = NULL,
    technology = NULL,
    has_publication = NULL,
    accession_code = NULL,
    alternate_accession_code = NULL,
    platform = NULL,
    organism = NULL,
    downloadable_organism = NULL,
    num_processed_samples = NULL,
    num_downloadable_samples = NULL,
    sample_keywords = NULL,
    ordering = NULL,
    search = NULL,
    pages = Inf,
    limit = 1000,
    .progress = TRUE,
    offset = 0) {
  args <- as.list(environment())
  args["pages"] <- NULL

  page <- 1

  res <- get_by_endpoint("search", query = args)
  count <- res$count
  results <- res$results
  if (.progress && limit > 0) {
    # if the total number of updates exceeds the "total"
    # argument to cli_progress_bar, the progress bar will
    # update call will result in an error:
    # Error in cli::cli_progress_update() :
    #     Cannot find current progress bar for `<environment: 0x15cc0c588>
    # so we add 1 to the total to avoid this
    cli::cli_progress_bar("Searching refine.bio",
      total = min(pages, ceiling(count / limit)) + 1
    )
    cli::cli_progress_update()
  }

  while ((offset < count) && (page < pages)) {
    offset <- offset + limit
    page <- page + 1
    if (.progress) cli::cli_progress_update()
    new_results <- get_by_endpoint("search",
      query = c(args, list(limit = limit, offset = offset))
    )$results
    results <- dplyr::bind_rows(results, new_results)
  }
  if (.progress) cli::cli_progress_done()
  attr(results, "count") <- count
  attr(results, "date") <- res$headers$date
  return(results)
}

#' Get experiment data for a single experiment
#'
#' Experiments are the top level of the refine.bio hierarchy.
#' They are collections of samples that were processed together.
#' This function returns metadata giving information about the
#' experiment, as well as a list of samples that are part of the
#' experiment.
#'
#' @returns
#' A list with the following elements:
#' - id: The ID of the experiment
#' - title: The title of the experiment
#' - description: A description of the experiment
#' - annotations: A list of annotations for the experiment
#' - samples: a data.frame of sample metadata
#' - protocol_description: A description of the protocol used in the experiment
#' - accession_code: The accession code of the experiment
#' - alternate_accession_code: An alternate accession code for the experiment
#' - source_database: The database from which the experiment was downloaded
#' - source_url: The URL from which the experiment was downloaded
#' - has_publication: Whether the experiment has a publication associated with it
#' - publication_title: The title of the publication associated with the experiment
#' - publication_doi: The DOI of the publication associated with the experiment
#' - publication_authors: The authors of the publication associated with the experiment
#' - pubmed_id: The PubMed ID of the publication associated with the experiment
#' - source_first_published: The date the experiment was first published
#' - source_last_modified: The date the experiment was last modified
#' - submitter_institution: The institution that submitted the experiment
#' - last_modified: The date the experiment was last modified
#' - created_at: The date the experiment was created
#' - organism_names: The names of the organisms in the experiment
#' - sample_metadata: The types of metadata available for the samples in the experiment
#' - num_total_samples: The total number of samples in the experiment
#' - num_processed_samples: The number of samples in the experiment that have been processed
#' - num_downloadable_samples: The number of samples in the experiment that are downloadable
#'
#' @param accession_code The accession code of the experiment, e.g. 'SRP150473'
#'
#' @examples
#' expt_details <- rb_experiment_details("SRP150473")
#'
#' expt_details$accession_code
#' expt_details$source_database
#' head(expt_details$samples)
#' expt_details$sample_metadata
#' expt_details$num_total_samples
#' expt_details$num_processed_samples
#' expt_details$num_downloadable_samples
#'
#' @export
rb_experiment_details <- function(accession_code) {
  get_by_endpoint(paste0("experiments/", accession_code))$results
}
