#' Unpaginated list of all the available "institution" information
#' @family institutions
#' @export
rb_institutions_list <- function(

)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$institutions_list
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$institutions_list
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
