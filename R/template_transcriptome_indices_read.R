#' Gets the S3 url associated with the organism and length, along with other metadata about
#' the transcriptome index we have stored.
#' @param id number Transcriptome Index Id eg `1` (required)


#' @family transcriptome_indices


rb_transcriptome_indices_read <- function(
    id
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$transcriptome_indices_read,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
