#' List all CompendiaResults with filtering.
#' @param primary_organism__name string  
#' @param compendium_version number  
#' @param quant_sf_only boolean `True` for RNA-seq Sample Compendium results or `False` for quantile normalized. 
#' @param result__id number  
#' @param ordering string Which field to use when ordering the results. 
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 
#' @param latest_version boolean `True` will only return the highest `compendium_version` for each primary_organism. 


#' @family compendia


rb_compendia_list <- function(
    primary_organism__name = NULL,
    compendium_version = NULL,
    quant_sf_only = NULL,
    result__id = NULL,
    ordering = NULL,
    limit = NULL,
    offset = NULL,
    latest_version = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$compendia_list,args)
        )
    res
}
