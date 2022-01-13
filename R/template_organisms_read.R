#' Retrieves an organism by its name.
#' @param name string  (required)
#' @family organisms
#' @export
rb_organisms_read <- function(
    name
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$organisms_read,args)
        )
    res
}
