#' Retrieve the details for a Sample given its accession code
#' @param accession_code string  (required)
#' @family samples
#' @export
rb_samples_read <- function(accession_code) {
    args <- as.list(environment())
    client <- rb_get_client()
    token <- rb_get_token()
    operation <- rapiclient::get_operations(client)$samples_read
    if (!is.null(token)) {
        headers <- c("API-KEY" = token)
        operation <- rapiclient::get_operations(client, .headers = headers)$samples_read
    }
    res <- .process_json_result(
        do.call(operation, args)
    )
    res
}
