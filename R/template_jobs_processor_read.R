#' Retrieves a ProcessorJob by ID
#' @family jobs
#' @export
rb_jobs_processor_read <- function(

)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$jobs_processor_read
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$jobs_processor_read
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
