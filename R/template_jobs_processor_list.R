#' List of all ProcessorJobs.
#' @param id number  
#' @param pipeline_applied string  
#' @param num_retries number  
#' @param retried string  
#' @param worker_id string  
#' @param ram_amount number  
#' @param volume_index string  
#' @param batch_job_queue string  
#' @param worker_version string  
#' @param failure_reason string  
#' @param batch_job_id string  
#' @param success string  
#' @param original_files string  
#' @param datasets string  
#' @param start_time string  
#' @param end_time string  
#' @param created_at string  
#' @param last_modified string  
#' @param ordering string Which field to use when ordering the results. 
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 
#' @param sample_accession_code string List the processor jobs associated with a sample 


#' @family jobs


rb_jobs_processor_list <- function(
    id = NULL,
    pipeline_applied = NULL,
    num_retries = NULL,
    retried = NULL,
    worker_id = NULL,
    ram_amount = NULL,
    volume_index = NULL,
    batch_job_queue = NULL,
    worker_version = NULL,
    failure_reason = NULL,
    batch_job_id = NULL,
    success = NULL,
    original_files = NULL,
    datasets = NULL,
    start_time = NULL,
    end_time = NULL,
    created_at = NULL,
    last_modified = NULL,
    ordering = NULL,
    limit = NULL,
    offset = NULL,
    sample_accession_code = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$jobs_processor_list,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
