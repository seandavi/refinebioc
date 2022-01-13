#' Get a detailed view of the Quantile Normalization file for an organism.
#' @param organism_name string Eg `DANIO_RERIO`, `MUS_MUSCULUS` (required)


#' @family qn_targets


rb_qn_targets_read <- function(
    organism_name
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$qn_targets_read,args)
        )
    res
}
