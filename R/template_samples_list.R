#' Returns detailed information about Samples
#' @param ordering string Which field to use when ordering the results. 
#' @param title string  
#' @param organism string  
#' @param source_database string  
#' @param source_archive_url string  
#' @param has_raw string  
#' @param platform_name string  
#' @param technology string  
#' @param manufacturer string  
#' @param sex string  
#' @param age number  
#' @param specimen_part string  
#' @param genotype string  
#' @param disease string  
#' @param disease_stage string  
#' @param cell_line string  
#' @param treatment string  
#' @param race string  
#' @param subject string  
#' @param compound string  
#' @param time string  
#' @param is_processed string  
#' @param is_unable_to_be_processed string  
#' @param is_public string  
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 
#' @param dataset_id string Filters the result and only returns samples that are added to a dataset. 
#' @param experiment_accession_code string Filters the result and only returns only the samples associated with an experiment accession code. 
#' @param accession_codes string Provide a list of sample accession codes separated by commas and the endpoint will only return information about these samples. 
#' @family samples
#' @export
rb_samples_list <- function(
    ordering = NULL,
    title = NULL,
    organism = NULL,
    source_database = NULL,
    source_archive_url = NULL,
    has_raw = NULL,
    platform_name = NULL,
    technology = NULL,
    manufacturer = NULL,
    sex = NULL,
    age = NULL,
    specimen_part = NULL,
    genotype = NULL,
    disease = NULL,
    disease_stage = NULL,
    cell_line = NULL,
    treatment = NULL,
    race = NULL,
    subject = NULL,
    compound = NULL,
    time = NULL,
    is_processed = NULL,
    is_unable_to_be_processed = NULL,
    is_public = NULL,
    limit = NULL,
    offset = NULL,
    dataset_id = NULL,
    experiment_accession_code = NULL,
    accession_codes = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$samples_list
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$samples_list
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
