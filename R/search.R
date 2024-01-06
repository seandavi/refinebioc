#' @export
rb_search_list <- function(
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
    limit = NULL,
    offset = NULL) {
  args <- as.list(environment())
  get_by_endpoint("/search/", query = args)
}
