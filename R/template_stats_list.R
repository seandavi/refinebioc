#' Statistics about the health of the system.
#' @param range string Specify a range from which to calculate the possible options 
#' @family stats
#' @export
rb_stats_list <- function(
    range = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$stats_list
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$stats_list
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
