#' API endpoint stats_failures_downloader_list
#'
#' @param range string Specify a range from which to calculate the possible options
#' @family stats
#' @export
rb_stats_failures_downloader_list <- function(range = NULL) {
    args <- as.list(environment())
    client <- rb_get_client()
    token <- rb_get_token()
    operation <- rapiclient::get_operations(client)$stats_failures_downloader_list
    if (!is.null(token)) {
        headers <- c("API-KEY" = token)
        operation <- rapiclient::get_operations(client, .headers = headers)$stats_failures_downloader_list
    }
    res <- .process_json_result(
        do.call(operation, args)
    )
    res
}
