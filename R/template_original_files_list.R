#' List Original Files that are associated with Samples. These are the files we proccess.
#' @param id number  
#' @param filename string  
#' @param samples string  
#' @param processor_jobs string  
#' @param downloader_jobs string  
#' @param size_in_bytes number  
#' @param sha1 string  
#' @param source_url string  
#' @param is_archive string  
#' @param source_filename string  
#' @param has_raw string  
#' @param created_at string  
#' @param last_modified string  
#' @param ordering string Which field to use when ordering the results. 
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 


#' @family original_files


rb_original_files_list <- function(
    id = NULL,
    filename = NULL,
    samples = NULL,
    processor_jobs = NULL,
    downloader_jobs = NULL,
    size_in_bytes = NULL,
    sha1 = NULL,
    source_url = NULL,
    is_archive = NULL,
    source_filename = NULL,
    has_raw = NULL,
    created_at = NULL,
    last_modified = NULL,
    ordering = NULL,
    limit = NULL,
    offset = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$original_files_list,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
