#' View and modify a single Dataset.
#' @param id string  
#' @param data object This is a dictionary where the keys are experiment accession codes and the values are lists with sample accession codes. Eg: `{'E-ABC-1': ['SAMP1', 'SAMP2']}` 
#' @param aggregate_by string Specifies how samples are [aggregated](http://docs.refine.bio/en/latest/main_text.html#aggregations). 
#' @param scale_by string Specifies options for [transformations](http://docs.refine.bio/en/latest/main_text.html#transformations). 
#' @param is_processing boolean  
#' @param is_processed boolean  
#' @param is_available boolean  
#' @param has_email string  
#' @param email_address string  
#' @param email_ccdl_ok boolean  
#' @param notify_me boolean  
#' @param expires_on string  
#' @param s3_bucket string  
#' @param s3_key string  
#' @param success boolean  
#' @param failure_reason string  
#' @param created_at string  
#' @param last_modified string  
#' @param start boolean  
#' @param size_in_bytes integer Contains the size in bytes of the processed dataset. 
#' @param sha1 string  
#' @param quantile_normalize boolean Part of the advanced options. Allows [skipping quantile normalization](http://docs.refine.bio/en/latest/faq.html#what-does-it-mean-to-skip-quantile-normalization-for-rna-seq-samples) for RNA-Seq samples. 
#' @param quant_sf_only boolean Include only quant.sf files in the generated dataset. 
#' @param svd_algorithm string Specifies choice of SVD algorithm 


#' @family dataset


rb_dataset_create <- function(
    id = NULL,
    data = NULL,
    aggregate_by = NULL,
    scale_by = NULL,
    is_processing = NULL,
    is_processed = NULL,
    is_available = NULL,
    has_email = NULL,
    email_address = NULL,
    email_ccdl_ok = NULL,
    notify_me = NULL,
    expires_on = NULL,
    s3_bucket = NULL,
    s3_key = NULL,
    success = NULL,
    failure_reason = NULL,
    created_at = NULL,
    last_modified = NULL,
    start = NULL,
    size_in_bytes = NULL,
    sha1 = NULL,
    quantile_normalize = NULL,
    quant_sf_only = NULL,
    svd_algorithm = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$dataset_create,args)
        )
    res
}
