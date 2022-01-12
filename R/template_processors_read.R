#' Retrieves a processor by its ID
#' @param id integer A unique integer value identifying this processor. (required)


#' @family processors


rb_processors_read <- function(
    id
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$processors_read,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
