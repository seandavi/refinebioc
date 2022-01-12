#' List all processors.
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 


#' @family processors


rb_processors_list <- function(
    limit = NULL,
    offset = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$processors_list,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
