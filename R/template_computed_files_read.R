#' Retrieves a computed file by its ID
#' @family computed_files
#' @export
rb_computed_files_read <- function(

)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$computed_files_read
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$computed_files_read
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
