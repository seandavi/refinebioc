#' Retrieves a ProcessorJob by ID
#' @param id integer A unique integer value identifying this processor job. (required)


#' @family jobs


rb_jobs_processor_read <- function(
    id
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$jobs_processor_read,args)
        )
    res
}
