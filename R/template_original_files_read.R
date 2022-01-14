#' Retrieves an Original File by its ID
#' @family original_files
#' @export
rb_original_files_read <- function(

)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$original_files_read
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$original_files_read
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
