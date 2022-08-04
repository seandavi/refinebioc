#' Paginated list of all the available organisms.
#' @param has_compendia string
#' @param has_quantfile_compendia string
#' @param limit integer Number of results to return per page.
#' @param offset integer The initial index from which to return the results.
#' @family organisms
#' @export
rb_organisms_list <- function(has_compendia = NULL,
                              has_quantfile_compendia = NULL,
                              limit = NULL,
                              offset = NULL) {
    args <- as.list(environment())
    client <- rb_get_client()
    token <- rb_get_token()
    operation <- rapiclient::get_operations(client)$organisms_list
    if (!is.null(token)) {
        headers <- c("API-KEY" = token)
        operation <- rapiclient::get_operations(client, .headers = headers)$organisms_list
    }
    res <- .process_json_result(
        do.call(operation, args)
    )
    res
}
