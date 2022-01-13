#' Unpaginated list of all the available "platform" information
#' @family platforms
#' @export
rb_platforms_list <- function(

)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$platforms_list,args)
        )
    res
}
