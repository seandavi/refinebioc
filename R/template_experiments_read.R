#' Retrieve details for an experiment given it's accession code
#' @param accession_code string  (required)


#' @family experiments


rb_experiments_read <- function(
    accession_code
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$experiments_read,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
