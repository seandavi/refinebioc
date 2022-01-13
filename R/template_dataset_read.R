#' View a single Dataset.
#' @param details boolean When set to `True`, additional fields will be included in the response with details about the experiments in the dataset. This is used mostly on the dataset page in www.refine.bio 


#' @family dataset


rb_dataset_read <- function(
    details = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$dataset_read,args)
        )
    res
}
