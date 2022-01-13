#' Retrieves an Original File by its ID
#' @param id integer A unique integer value identifying this original file. (required)


#' @family original_files


rb_original_files_read <- function(
    id
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$original_files_read,args)
        )
    res
}
