#' List of all DownloaderJob
#' @param id number  
#' @param downloader_task string  
#' @param ram_amount number  
#' @param num_retries number  
#' @param retried string  
#' @param was_recreated string  
#' @param worker_id string  
#' @param worker_version string  
#' @param batch_job_id string  
#' @param batch_job_queue string  
#' @param failure_reason string  
#' @param success string  
#' @param original_files string  
#' @param start_time string  
#' @param end_time string  
#' @param created_at string  
#' @param last_modified string  
#' @param ordering string Which field to use when ordering the results. 
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 
#' @param sample_accession_code string List the downloader jobs associated with a sample 
#' @family jobs
#' @export
rb_jobs_downloader_list <- function(
    id = NULL,
    downloader_task = NULL,
    ram_amount = NULL,
    num_retries = NULL,
    retried = NULL,
    was_recreated = NULL,
    worker_id = NULL,
    worker_version = NULL,
    batch_job_id = NULL,
    batch_job_queue = NULL,
    failure_reason = NULL,
    success = NULL,
    original_files = NULL,
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
        do.call(rapiclient::get_operations(client)$jobs_downloader_list,args)
        )
    res
}
