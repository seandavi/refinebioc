#' Retrieve the details for a Sample given its accession code
#' @param accession_code string  (required)


#' @family samples


rb_samples_read <- function(
    accession_code
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$samples_read,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
