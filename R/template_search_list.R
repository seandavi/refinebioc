#' 
#' Use this endpoint to search among the experiments.
#' 
#' This is powered by ElasticSearch, information regarding advanced usages of the
#' filters can be found in the [Django-ES-DSL-DRF docs](https://django-elasticsearch-dsl-drf.readthedocs.io/en/0.17.1/filtering_usage_examples.html#filtering)
#' 
#' There's an additional field in the response named `facets` that contain stats on the number of results per filter type.
#' 
#' Example Requests:
#' ```
#' ?search=medulloblastoma
#' ?id=1
#' ?search=medulloblastoma&technology=microarray&has_publication=true
#' ?ordering=source_first_published
#' ```
#' 
#' This endpoint also accepts POST requests for larger queries. Any of the filters
#' accepted as query parameters are also accepted in a JSON object in the request
#' body.
#' 
#' Example Requests (from our tests):
#' ```python
#' import requests
#' import json
#' 
#' headers = {
#'     'Content-Type': 'application/json',
#' }
#' 
#' # Basic filter
#' search = {"accession_code": "GSE123"}
#' requests.post(host + '/v1/search/', json.dumps(search), headers=headers)
#' 
#' # __in filter
#' search = {"accession_code__in": ["GSE123"]}
#' requests.post(host + '/v1/search/', json.dumps(search), headers=headers)
#' 
#' # numeric filter
#' search = {"num_downloadable_samples__gt": 0}
#' requests.post(host + '/v1/search/', json.dumps(search), headers=headers)
#' ```
#' 
#' @param id number  
#' @param technology string Allows filtering the results by technology, can have multiple values. Eg: `?technology=microarray&technology=rna-seq` 
#' @param has_publication string Filter the results that have associated publications with `?has_publication=true` 
#' @param accession_code string Allows filtering the results by accession code, can have multiple values. Eg: `?accession_code=microarray&accession_code=rna-seq` 
#' @param alternate_accession_code string  
#' @param platform string Allows filtering the results by platform, this parameter can have multiple values. 
#' @param organism string Allows filtering the results by organism, this parameter can have multiple values. 
#' @param downloadable_organism string  
#' @param num_processed_samples number Use ElasticSearch queries to specify the number of processed samples of the results 
#' @param num_downloadable_samples number  
#' @param sample_keywords string  
#' @param ordering string Which field from to use when ordering the results. 
#' @param search string Search in title, publication_authors, sample_keywords, publication_title, submitter_institution, description, accession_code, alternate_accession_code, publication_doi, pubmed_id, sample_metadata_fields, platform_names. 
#' @param limit integer Number of results to return per page. 
#' @param offset integer The initial index from which to return the results. 


#' @family search


rb_search_list <- function(
    id = NULL,
    technology = NULL,
    has_publication = NULL,
    accession_code = NULL,
    alternate_accession_code = NULL,
    platform = NULL,
    organism = NULL,
    downloadable_organism = NULL,
    num_processed_samples = NULL,
    num_downloadable_samples = NULL,
    sample_keywords = NULL,
    ordering = NULL,
    search = NULL,
    limit = NULL,
    offset = NULL
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$search_list,args)
        )
    res
}
