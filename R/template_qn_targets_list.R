#' This is a list of all of the organisms which have available QN Targets
#' @family qn_targets
#' @export
rb_qn_targets_list <- function() {
    args <- as.list(environment())
    client <- rb_get_client()
    token <- rb_get_token()
    operation <- rapiclient::get_operations(client)$qn_targets_list
    if (!is.null(token)) {
        headers <- c("API-KEY" = token)
        operation <- rapiclient::get_operations(client, .headers = headers)$qn_targets_list
    }
    res <- .process_json_result(
        do.call(operation, args)
    )
    res
}
