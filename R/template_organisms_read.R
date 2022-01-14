#' Retrieves an organism by its name.
#' @param name string  (required)
#' @family organisms
#' @export
rb_organisms_read <- function(
    name
)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$organisms_read
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$organisms_read
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
