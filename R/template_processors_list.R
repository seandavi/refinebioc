#' List all processors.
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 
#' @family processors
#' @export
rb_processors_list <- function(
    limit = NULL,
    offset = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$processors_list
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$processors_list
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
