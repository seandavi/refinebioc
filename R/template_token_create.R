#' 
#' This endpoint can be used to create and activate tokens. These tokens can be used
#' in requests that provide urls to download computed files. Setting `is_activated` to
#' true indicates agreement with refine.bio's [Terms of Use](https://www.refine.bio/terms)
#' and [Privacy Policy](https://www.refine.bio/privacy).
#' 
#' ```py
#' import requests
#' import json
#' 
#' response = requests.post('https://api.refine.bio/v1/token/')
#' token_id = response.json()['id']
#' response = requests.put('https://api.refine.bio/v1/token/' + token_id + '/', json.dumps({'is_activated': True}), headers={'Content-Type': 'application/json'})
#' ```
#' 
#' The token id needs to be provided in the HTTP request in the API-KEY header.
#' 
#' References
#' - [https://github.com/AlexsLemonade/refinebio/issues/731]()
#' - [https://github.com/AlexsLemonade/refinebio-frontend/issues/560]()
#' 
#' @param id string  
#' @param is_activated boolean  
#' @param terms_and_conditions string  


#' @family token


rb_token_create <- function(
    id = NULL,
    is_activated = NULL,
    terms_and_conditions = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$token_create,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
