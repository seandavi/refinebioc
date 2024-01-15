#' Complete list of all experiments in refine.bio
#'
#' Refine.bio experiments are collections
#' of samples that were processed together.
#' In practices, refine.bio experiments
#' are usually a GEO series or an SRA study.
#' This function returns a list of all experiments in refine.bio as a tibble.
#'
#' @param .pages `integer(1)` The number of pages to retrieve. Will return
#'  all pages if `NULL` (default). Generally, you'll want to ignore this;
#'  it's only useful for testing.
#'
#' @author
#'   - Sean Davis <seandavi@gmail.com>
#'   - Alex Ho <alexander.2.ho@cuanschutz.edu>
#'
#' @family experiments
#'
#' @return `tibble` A tibble of all experiments in refine.bio.
#'
#' The tibble contains the following columns:
#'
#' - id: The ID of the experiment
#' - title: The title of the experiment
#' - publication_title: The title of the
#'   publication associated with the experiment
#' - description: A description of the experiment
#' - accession_code: The accession code of the experiment
#' - alternate_accession_code: An alternate accession code for the experiment
#' - technology: The technology used to generate the data in the experiment
#' - submitter_institution: The institution that submitted the experiment
#' - has_publication: Whether the experiment
#'   has a publication associated with it
#' - publication_doi: The DOI of the publication associated with the experiment
#' - publication_authors: The authors of
#'   the publication associated with the experiment
#' - pubmed_id: The PubMed ID of the publication associated with the experiment
#' - source_first_published: The date the experiment was first published
#' - num_total_samples: The total number of samples in the experiment
#' - num_processed_samples: The number of samples
#'   in the experiment that have been processed
#' - num_downloadable_samples: The number of samples
#'   in the experiment that are downloadable
#' - platform_names: The names of the platforms used in the experiment
#' - organism_names: The names of the organisms in the experiment
#' - sample_metadata_fields: The types of metadata
#'   available for the samples in the experiment
#' - samples: a data.frame of sample metadata
#'

#' @examples
#' # this takes about 1-2 minutes to complete
#' # for the entire experiment listing
#' # depending on your internet connection
#' # You only need to do this once (or when you want
#' #   to update the results)
#'
#' # get the first 2 pages of experiments for
#' # testing and demonstration purposes
#' experiments <- experiment_listing(.pages = 2)
#'
#' # get all experiments
#' # experiments <- experiment_listing()
#'
#' head(experiments)
#' dim(experiments)
#' colnames(experiments)
#'
#' @export
experiment_listing <- function(.pages) {
  args <- list()
  args["pages"] <- NULL

  limit <- 1000
  offset <- 0

  page <- 1

  .progress <- interactive()

  res <- get_by_endpoint("search", query = list(limit = limit, page = 0))
  count <- res$count
  results <- tibble::as_tibble(res$results)
  if (.progress) {
    # if the total number of updates exceeds the "total"
    # argument to cli_progress_bar, the progress bar will
    # update call will result in an error:
    # Error in cli::cli_progress_update() :
    #     Cannot find current progress bar for `<environment: 0x15cc0c588>
    # so we add 1 to the total to avoid this
    cli::cli_progress_bar("Getting experiment metadata... ",
      total = max(.pages, ceiling(count / limit)) + 1
    )
    cli::cli_progress_update()
  }

  while ((offset < count) && (page < .pages)) {
    offset <- offset + limit
    page <- page + 1
    if (.progress) cli::cli_progress_update()
    new_results <- get_by_endpoint("search",
      query = c(args, list(limit = limit, offset = offset))
    )$results
    new_results <- tibble::as_tibble(new_results)
    results <- dplyr::bind_rows(results, new_results)
  }
  results$source_first_published <- as.Date(results$source_first_published)
  if (.progress) cli::cli_progress_done()
  attr(results, "date") <- res$headers$date
  return(results)
}
