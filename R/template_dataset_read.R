#' View a single Dataset.
#' @param details boolean When set to `True`, additional fields will be included in the response with details about the experiments in the dataset. This is used mostly on the dataset page in www.refine.bio 
#' @family dataset
#' @export
rb_dataset_read <- function(
    details = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$dataset_read
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$dataset_read
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
