#' Turn facet results into data.frame
#'
#' @param facet_list list() with names representing facets and values
#'   for each element representing the count of such facet in the
#'   search result
#'
#' @returns `data.frame` with columns
#'   - category
#'   - count
#'
#' @keywords internal
.facet_to_data_frame = function(facet_list) {
    res = data.frame(category=names(facet_list),
                     count=as.numeric(facet_list))
    return(res[order(res$count,decreasing=TRUE),])
}

#' Perform a search against refine.bio api
#'
#' @param id integer(1) the ID to search for
#' @param technology character() vector of technologies to search
#' @param has_publiction logical(1) filter out records that do not have
#'   associated publications
#' @param accession_code character() vector of accessions
#' @param alternate_accession_ccode character() vector of alternate accession
#'   codes
#' @param platform character() vector of platforms to include
#' @param organism character() vector of organisms to include
#' @param downloadable_organism character() vector of organisms with data
#'   available for download
#' @param num_processed_samples integer() number of processed samples
#' @param sample_keywords character() vector of sample keywords to include
#' @param ordering character() which field to use when ordering results
#' @param search character(1) Search in title, publication_authors,
#' sample_keywords, publication_title, submitter_institution, description,
#' accession_code, alternate_accession_code, publication_doi,
#' pubmed_id, sample_metadata_fields, platform_names.
#'
#' @param limit integer(1) number of results to return per page
#' @param offset integer(1) the initial offset from with to return the
#'   results
#' @param total integer(1) the total number of records to return
#'
#' @examples
#'
#' client = RefineBio::RefineBio()
#'
#' sres = rb_search(client)
#' sres$count
#' head(sres$results,4)
#' lapply(sres$facets,head)
#'
#'
#' @export
rb_search <- function(client,...) {
    res = .process_json_result(
        rapiclient::get_operations(client)$search_list(...)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
