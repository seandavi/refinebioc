#' List all Transcriptome Indices. These are a special type of process result,
#' necessary for processing other SRA samples.
#' @param salmon_version string Eg. `salmon 0.13.1`
#' @param index_type string Eg. `TRANSCRIPTOME_LONG`
#' @param ordering string Which field to use when ordering the results.
#' @param limit integer Number of results to return per page.
#' @param offset integer The initial index from which to return the results.
#' @param organism__name string Organism name. Eg. `MUS_MUSCULUS`
#' @param length string Short hand for `index_type` Eg. `short` or `long`
#' @family transcriptome_indices
#' @export
rb_transcriptome_indices_list <- function(salmon_version = NULL,
                                          index_type = NULL,
                                          ordering = NULL,
                                          limit = NULL,
                                          offset = NULL,
                                          organism__name = NULL,
                                          length = NULL) {
    args <- as.list(environment())
    client <- rb_get_client()
    token <- rb_get_token()
    operation <- rapiclient::get_operations(client)$transcriptome_indices_list
    if (!is.null(token)) {
        headers <- c("API-KEY" = token)
        operation <- rapiclient::get_operations(client, .headers = headers)$transcriptome_indices_list
    }
    res <- .process_json_result(
        do.call(operation, args)
    )
    res
}
