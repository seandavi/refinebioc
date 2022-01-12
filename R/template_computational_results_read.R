#' Retrieves a computational result by its ID
#' @param id integer A unique integer value identifying this computational result. (required)


#' @family computational_results


rb_computational_results_read <- function(
    id
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$computational_results_read,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
