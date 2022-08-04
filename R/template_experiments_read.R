#' Retrieve details for an experiment given it's accession code
#' @param accession_code string  (required)
#' @family experiments
#' @export
rb_experiments_read <- function(accession_code) {
    args <- as.list(environment())
    client <- rb_get_client()
    token <- rb_get_token()
    operation <- rapiclient::get_operations(client)$experiments_read
    if (!is.null(token)) {
        headers <- c("API-KEY" = token)
        operation <- rapiclient::get_operations(client, .headers = headers)$experiments_read
    }
    res <- .process_json_result(
        do.call(operation, args)
    )
    res
}
