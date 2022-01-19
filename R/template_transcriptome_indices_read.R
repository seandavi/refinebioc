#' Gets the S3 url associated with the organism and length, along with other metadata about
#' the transcriptome index we have stored.
#' @param id number Transcriptome Index Id eg `1` (required)
#' @family transcriptome_indices
#' @export
rb_transcriptome_indices_read <- function(
    id
)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$transcriptome_indices_read
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$transcriptome_indices_read
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
