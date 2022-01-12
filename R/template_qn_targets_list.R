#' This is a list of all of the organisms which have available QN Targets


#' @family qn_targets


rb_qn_targets_list <- function(

)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$qn_targets_list,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
