#' Get a specific Compendium Result
#' @param id integer A unique integer value identifying this compendium result. (required)


#' @family compendia


rb_compendia_read <- function(
    id
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$compendia_read,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
