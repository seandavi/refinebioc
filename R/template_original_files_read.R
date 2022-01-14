#' Retrieves an Original File by its ID
#' @param id integer A unique integer value identifying this original file. (required)
#' @family original_files
#' @export
rb_original_files_read <- function(
    id
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
