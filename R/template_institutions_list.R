#' Unpaginated list of all the available "institution" information


#' @family institutions


rb_institutions_list <- function(

)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$institutions_list,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
