#' Retrieves a processor by its ID
#' @family processors
#' @export
rb_processors_read <- function(

)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$processors_read
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$processors_read
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
