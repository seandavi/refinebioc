#' Paginated list of all the available organisms.
#' @param has_compendia string  
#' @param has_quantfile_compendia string  
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 


#' @family organisms


rb_organisms_list <- function(
    has_compendia = NULL,
    has_quantfile_compendia = NULL,
    limit = NULL,
    offset = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$organisms_list,args)
        )
    res
}
