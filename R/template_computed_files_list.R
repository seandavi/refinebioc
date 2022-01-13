#' ComputedFiles are representation of files created by refinebio processes.
#' 
#' It's possible to download each one of these files by providing a valid token. To
#' acquire and activate an API key see the documentation for the [/token](#tag/token) endpoint.
#' When a valid token is provided the url will be sent back in the field `download_url`. Example:
#' ```py
#' import requests
#' import json
#' headers = {
#'     'Content-Type': 'application/json',
#'     'API-KEY': token_id # requested from /token
#' }
#' requests.get('https://api.refine.bio/v1/computed_files/?id=5796866', {}, headers=headers)
#' ```
#' This endpoint can also be used to fetch all the compendia files we have generated with:
#' ```
#' GET /computed_files?is_compendia=True&is_public=True
#' ```
#' @param id number  
#' @param samples string  
#' @param is_qn_target string  
#' @param is_smashable string  
#' @param is_qc string  
#' @param is_compendia string  
#' @param quant_sf_only string  
#' @param svd_algorithm string  
#' @param compendium_version number  
#' @param created_at string  
#' @param last_modified string  
#' @param result__id number  
#' @param ordering string Which field to use when ordering the results. 
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 
#' @family computed_files
#' @export
rb_computed_files_list <- function(
    id = NULL,
    samples = NULL,
    is_qn_target = NULL,
    is_smashable = NULL,
    is_qc = NULL,
    is_compendia = NULL,
    quant_sf_only = NULL,
    svd_algorithm = NULL,
    compendium_version = NULL,
    created_at = NULL,
    last_modified = NULL,
    result__id = NULL,
    ordering = NULL,
    limit = NULL,
    offset = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$computed_files_list,args)
        )
    res
}
