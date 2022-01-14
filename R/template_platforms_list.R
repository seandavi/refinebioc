#' Unpaginated list of all the available "platform" information
#' @family platforms
#' @export
rb_platforms_list <- function(

)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$platforms_list
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$platforms_list
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
