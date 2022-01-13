#' Return details about a specific token.
#' @param id string A UUID string identifying this api token. (required)


#' @family token


rb_token_read <- function(
    id
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$token_read,args)
        )
    res
}
