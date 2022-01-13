#' Paginated list of all experiments. Advanced filtering can be done with the `/search` endpoint.
#' @param title string  
#' @param description string  
#' @param accession_code string  
#' @param alternate_accession_code string  
#' @param source_database string  
#' @param source_url string  
#' @param has_publication string  
#' @param publication_title string  
#' @param publication_doi string  
#' @param pubmed_id string  
#' @param organisms string  
#' @param submitter_institution string  
#' @param created_at string  
#' @param last_modified string  
#' @param source_first_published string  
#' @param source_last_modified string  
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 


#' @family experiments


rb_experiments_list <- function(
    title = NULL,
    description = NULL,
    accession_code = NULL,
    alternate_accession_code = NULL,
    source_database = NULL,
    source_url = NULL,
    has_publication = NULL,
    publication_title = NULL,
    publication_doi = NULL,
    pubmed_id = NULL,
    organisms = NULL,
    submitter_institution = NULL,
    created_at = NULL,
    last_modified = NULL,
    source_first_published = NULL,
    source_last_modified = NULL,
    limit = NULL,
    offset = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$experiments_list,args)
        )
    res
}
