#' This lists all `ComputationalResult`. Each one contains meta-information about the output of a computer process. (Ex Salmon).
#' 
#' This can return valid S3 urls if a valid [token](#tag/token) is sent in the header `HTTP_API_KEY`.
#' @param processor__id number  
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 
#' @family computational_results
#' @export
rb_computational_results_list <- function(
    processor__id = NULL,
    limit = NULL,
    offset = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$computational_results_list,args)
        )
    res
}
