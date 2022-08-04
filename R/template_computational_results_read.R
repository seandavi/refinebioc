#' Retrieves a computational result by its ID
#' @param id integer A unique integer value identifying this computational result. (required)
#' @family computational_results
#' @export
rb_computational_results_read <- function(id) {
    args <- as.list(environment())
    client <- rb_get_client()
    token <- rb_get_token()
    operation <- rapiclient::get_operations(client)$computational_results_read
    if (!is.null(token)) {
        headers <- c("API-KEY" = token)
        operation <- rapiclient::get_operations(client, .headers = headers)$computational_results_read
    }
    res <- .process_json_result(
        do.call(operation, args)
    )
    res
}
