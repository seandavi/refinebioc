#' API endpoint stats_failures_downloader_list
#'
#' @param range string Specify a range from which to calculate the possible options 
#' @family stats
#' @export
rb_stats_failures_downloader_list <- function(
    range = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$stats_failures_downloader_list,args)
        )
    res
}
