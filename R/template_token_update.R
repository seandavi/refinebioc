#' 
#' This can be used to activate a specific token by sending `is_activated: true`.
#' Setting `is_activated` to true indicates agreement with refine.bio's
#' [Terms of Use](https://www.refine.bio/terms) and
#' [Privacy Policy](https://www.refine.bio/privacy).
#' 
#' @param id string  
#' @param is_activated boolean  
#' @param terms_and_conditions string  


#' @family token


rb_token_update <- function(
    id = NULL,
    is_activated = NULL,
    terms_and_conditions = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$token_update,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
