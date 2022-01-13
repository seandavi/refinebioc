#' List of all SurveyJob.
#' @param id number  
#' @param source_type string  
#' @param success string  
#' @param batch_job_id string  
#' @param batch_job_queue string  
#' @param ram_amount number  
#' @param start_time string  
#' @param end_time string  
#' @param created_at string  
#' @param last_modified string  
#' @param ordering string Which field to use when ordering the results. 
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 


#' @family jobs


rb_jobs_survey_list <- function(
    id = NULL,
    source_type = NULL,
    success = NULL,
    batch_job_id = NULL,
    batch_job_queue = NULL,
    ram_amount = NULL,
    start_time = NULL,
    end_time = NULL,
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
        do.call(rapiclient::get_operations(client)$jobs_survey_list,args)
        )
    res
}
