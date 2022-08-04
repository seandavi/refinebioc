#' Get a specific Compendium Result
#' @param id integer A unique integer value identifying this compendium result. (required)
#' @family compendia
#' @export
rb_compendia_read <- function(id) {
    args <- as.list(environment())
    client <- rb_get_client()
    token <- rb_get_token()
    operation <- rapiclient::get_operations(client)$compendia_read
    if (!is.null(token)) {
        headers <- c("API-KEY" = token)
        operation <- rapiclient::get_operations(client, .headers = headers)$compendia_read
    }
    res <- .process_json_result(
        do.call(operation, args)
    )
    res
}
