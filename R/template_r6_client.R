#' The entrypoint for the RefineBio API
#'
#' Here we start
RefineBioClient <- R6::R6Class(
  "RefineBioClient",
  public = list(
    #' List all CompendiaResults with filtering.
    #' @param primary_organism__name string
    #' @param compendium_version number
    #' @param quant_sf_only boolean `True` for RNA-seq Sample Compendium results or `False` for quantile normalized.
    #' @param result__id number
    #' @param ordering string Which field to use when ordering the results.
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @param latest_version boolean `True` will only return the highest `compendium_version` for each primary_organism.
    #' @family compendia
    rb_compendia_list = function(primary_organism__name = NULL,
                                 compendium_version = NULL,
                                 quant_sf_only = NULL,
                                 result__id = NULL,
                                 ordering = NULL,
                                 limit = NULL,
                                 offset = NULL,
                                 latest_version = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/compendia/", query = args)
    },
    #' This lists all `ComputationalResult`. Each one contains meta-information about the output of a computer process. (Ex Salmon).
    #'
    #' This can return valid S3 urls if a valid [token](#tag/token) is sent in the header `HTTP_API_KEY`.
    #' @param processor__id number
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @family computational_results

    rb_computational_results_list = function(processor__id = NULL,
                                             limit = NULL,
                                             offset = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/computational_results/", query = args)
    },
    #' ComputedFiles are representation of files created by refinebio processes.
    #'
    #' It's possible to download each one of these files by providing a valid token. To
    #' acquire and activate an API key see the documentation for the [/token](#tag/token) endpoint.
    #' When a valid token is provided the url will be sent back in the field `download_url`. Example:
    #' ```py
    #' import requests
    #' import json
    #' headers = {
    #'     'Content-Type': 'application/json',
    #'     'API-KEY': token_id # requested from /token
    #' }
    #' requests.get('https://api.refine.bio/v1/computed_files/?id=5796866', {}, headers=headers)
    #' ```
    #' This endpoint can also be used to fetch all the compendia files we have generated with:
    #' ```
    #' GET /computed_files?is_compendia=True&is_public=True
    #' ```
    #' @param id number
    #' @param samples string
    #' @param is_qn_target string
    #' @param is_smashable string
    #' @param is_qc string
    #' @param is_compendia string
    #' @param quant_sf_only string
    #' @param svd_algorithm string
    #' @param compendium_version number
    #' @param created_at string
    #' @param last_modified string
    #' @param result__id number
    #' @param ordering string Which field to use when ordering the results.
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @family computed_files

    rb_computed_files_list = function(id = NULL,
                                      samples = NULL,
                                      is_qn_target = NULL,
                                      is_smashable = NULL,
                                      is_qc = NULL,
                                      is_compendia = NULL,
                                      quant_sf_only = NULL,
                                      svd_algorithm = NULL,
                                      compendium_version = NULL,
                                      created_at = NULL,
                                      last_modified = NULL,
                                      result__id = NULL,
                                      ordering = NULL,
                                      limit = NULL,
                                      offset = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/computed_files/", query = args)
    },
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

    rb_dataset_create = function(id = NULL,
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
                                 svd_algorithm = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/dataset/", query = args)
    },
    #'
    #' Modify an existing Dataset.
    #'
    #' In order to begin smashing, an activated API key must be provided in the `API-KEY` header field of the request.
    #' To acquire and activate an API key see the documentation for the [/token](#tag/token)
    #' endpoint.
    #'
    #' ```py
    #' import requests
    #' import json
    #'
    #' params = json.dumps({
    #'     'data': data,
    #'     'aggregate_by': 'EXPERIMENT',
    #'     'start': True,
    #'     'email_address': 'refinebio@gmail.com'
    #' })
    #' headers = {
    #'     'Content-Type': 'application/json',
    #'     'API-KEY': token_id # requested from /token
    #' }
    #' requests.put(host + '/v1/dataset/38879729-93c8-436d-9293-b95d3f274741/', params, headers=headers)
    #' ```
    #'
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

    rb_dataset_update = function(id = NULL,
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
                                 svd_algorithm = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/dataset/{id}/", query = args)
    },
    #' Paginated list of all experiments. Advanced filtering can be done with the `/search` endpoint.
    #' @param title string
    #' @param description string
    #' @param accession_code string
    #' @param alternate_accession_code string
    #' @param source_database string
    #' @param source_url string
    #' @param has_publication string
    #' @param publication_title string
    #' @param publication_doi string
    #' @param pubmed_id string
    #' @param organisms string
    #' @param submitter_institution string
    #' @param created_at string
    #' @param last_modified string
    #' @param source_first_published string
    #' @param source_last_modified string
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @family experiments

    rb_experiments_list = function(title = NULL,
                                   description = NULL,
                                   accession_code = NULL,
                                   alternate_accession_code = NULL,
                                   source_database = NULL,
                                   source_url = NULL,
                                   has_publication = NULL,
                                   publication_title = NULL,
                                   publication_doi = NULL,
                                   pubmed_id = NULL,
                                   organisms = NULL,
                                   submitter_institution = NULL,
                                   created_at = NULL,
                                   last_modified = NULL,
                                   source_first_published = NULL,
                                   source_last_modified = NULL,
                                   limit = NULL,
                                   offset = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/experiments/", query = args)
    },
    #' Unpaginated list of all the available "institution" information
    #' @family institutions

    rb_institutions_list = function() {
      args <- as.list(environment())
      get_by_endpoint("/institutions/", query = args)
    },
    #' List of all DownloaderJob
    #' @param id number
    #' @param downloader_task string
    #' @param ram_amount number
    #' @param num_retries number
    #' @param retried string
    #' @param was_recreated string
    #' @param worker_id string
    #' @param worker_version string
    #' @param batch_job_id string
    #' @param batch_job_queue string
    #' @param failure_reason string
    #' @param success string
    #' @param original_files string
    #' @param start_time string
    #' @param end_time string
    #' @param created_at string
    #' @param last_modified string
    #' @param ordering string Which field to use when ordering the results.
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @param sample_accession_code string List the downloader jobs associated with a sample
    #' @family jobs

    rb_jobs_downloader_list = function(id = NULL,
                                       downloader_task = NULL,
                                       ram_amount = NULL,
                                       num_retries = NULL,
                                       retried = NULL,
                                       was_recreated = NULL,
                                       worker_id = NULL,
                                       worker_version = NULL,
                                       batch_job_id = NULL,
                                       batch_job_queue = NULL,
                                       failure_reason = NULL,
                                       success = NULL,
                                       original_files = NULL,
                                       start_time = NULL,
                                       end_time = NULL,
                                       created_at = NULL,
                                       last_modified = NULL,
                                       ordering = NULL,
                                       limit = NULL,
                                       offset = NULL,
                                       sample_accession_code = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/jobs/downloader/", query = args)
    },
    #' List of all ProcessorJobs.
    #' @param id number
    #' @param pipeline_applied string
    #' @param num_retries number
    #' @param retried string
    #' @param worker_id string
    #' @param ram_amount number
    #' @param volume_index string
    #' @param batch_job_queue string
    #' @param worker_version string
    #' @param failure_reason string
    #' @param batch_job_id string
    #' @param success string
    #' @param original_files string
    #' @param datasets string
    #' @param start_time string
    #' @param end_time string
    #' @param created_at string
    #' @param last_modified string
    #' @param ordering string Which field to use when ordering the results.
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @param sample_accession_code string List the processor jobs associated with a sample
    #' @family jobs

    rb_jobs_processor_list = function(id = NULL,
                                      pipeline_applied = NULL,
                                      num_retries = NULL,
                                      retried = NULL,
                                      worker_id = NULL,
                                      ram_amount = NULL,
                                      volume_index = NULL,
                                      batch_job_queue = NULL,
                                      worker_version = NULL,
                                      failure_reason = NULL,
                                      batch_job_id = NULL,
                                      success = NULL,
                                      original_files = NULL,
                                      datasets = NULL,
                                      start_time = NULL,
                                      end_time = NULL,
                                      created_at = NULL,
                                      last_modified = NULL,
                                      ordering = NULL,
                                      limit = NULL,
                                      offset = NULL,
                                      sample_accession_code = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/jobs/processor/", query = args)
    },
    #' List of all SurveyJob.
    #' @param id number
    #' @param source_type string
    #' @param success string
    #' @param batch_job_id string
    #' @param batch_job_queue string
    #' @param ram_amount number
    #' @param start_time string
    #' @param end_time string
    #' @param created_at string
    #' @param last_modified string
    #' @param ordering string Which field to use when ordering the results.
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @family jobs

    rb_jobs_survey_list = function(id = NULL,
                                   source_type = NULL,
                                   success = NULL,
                                   batch_job_id = NULL,
                                   batch_job_queue = NULL,
                                   ram_amount = NULL,
                                   start_time = NULL,
                                   end_time = NULL,
                                   created_at = NULL,
                                   last_modified = NULL,
                                   ordering = NULL,
                                   limit = NULL,
                                   offset = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/jobs/survey/", query = args)
    },
    #' Paginated list of all the available organisms.
    #' @param has_compendia string
    #' @param has_quantfile_compendia string
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @family organisms

    rb_organisms_list = function(has_compendia = NULL,
                                 has_quantfile_compendia = NULL,
                                 limit = NULL,
                                 offset = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/organisms/", query = args)
    },
    #' List Original Files that are associated with Samples. These are the files we proccess.
    #' @param id number
    #' @param filename string
    #' @param samples string
    #' @param processor_jobs string
    #' @param downloader_jobs string
    #' @param size_in_bytes number
    #' @param sha1 string
    #' @param source_url string
    #' @param is_archive string
    #' @param source_filename string
    #' @param has_raw string
    #' @param created_at string
    #' @param last_modified string
    #' @param ordering string Which field to use when ordering the results.
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @family original_files

    rb_original_files_list = function(id = NULL,
                                      filename = NULL,
                                      samples = NULL,
                                      processor_jobs = NULL,
                                      downloader_jobs = NULL,
                                      size_in_bytes = NULL,
                                      sha1 = NULL,
                                      source_url = NULL,
                                      is_archive = NULL,
                                      source_filename = NULL,
                                      has_raw = NULL,
                                      created_at = NULL,
                                      last_modified = NULL,
                                      ordering = NULL,
                                      limit = NULL,
                                      offset = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/original_files/", query = args)
    },
    #' Unpaginated list of all the available "platform" information
    #' @family platforms

    rb_platforms_list = function() {
      args <- as.list(environment())
      get_by_endpoint("/platforms/", query = args)
    },
    #' List all processors.
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @family processors

    rb_processors_list = function(limit = NULL,
                                  offset = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/processors/", query = args)
    },
    #' This is a list of all of the organisms which have available QN Targets
    #' @family qn_targets

    rb_qn_targets_list = function() {
      args <- as.list(environment())
      get_by_endpoint("/qn_targets/", query = args)
    },
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

    rb_samples_list = function(ordering = NULL,
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
                               accession_codes = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/samples/", query = args)
    },
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

    rb_search_list = function(id = NULL,
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
                              offset = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/search/", query = args)
    },
    #' Statistics about the health of the system.
    #' @param range string Specify a range from which to calculate the possible options
    #' @family stats

    rb_stats_list = function(range = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/stats/", query = args)
    },
    #' API endpoint stats_failures_downloader_list
    #'
    #' @param range string Specify a range from which to calculate the possible options
    #' @family stats

    rb_stats_failures_downloader_list = function(range = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/stats/failures/downloader", query = args)
    },
    #' API endpoint stats_failures_processor_list
    #'
    #' @param range string Specify a range from which to calculate the possible options
    #' @family stats

    rb_stats_failures_processor_list = function(range = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/stats/failures/processor", query = args)
    },
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

    rb_token_create = function(id = NULL,
                               is_activated = NULL,
                               terms_and_conditions = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/token/", query = args)
    },
    #'
    #' This can be used to activate a specific token by sending `is_activated: true`.
    #' Setting `is_activated` to true indicates agreement with refine.bio's
    #' [Terms of Use](https://www.refine.bio/terms) and
    #' [Privacy Policy](https://www.refine.bio/privacy).
    #'
    #' @param id string
    #' @param is_activated boolean
    #' @param terms_and_conditions string
    #' @family token

    rb_token_update = function(id = NULL,
                               is_activated = NULL,
                               terms_and_conditions = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/token/{id}/", query = args)
    },
    #' List all Transcriptome Indices. These are a special type of process result,
    #' necessary for processing other SRA samples.
    #' @param salmon_version string Eg. `salmon 0.13.1`
    #' @param index_type string Eg. `TRANSCRIPTOME_LONG`
    #' @param ordering string Which field to use when ordering the results.
    #' @param limit integer Number of results to return per page.
    #' @param offset integer The initial index from which to return the results.
    #' @param organism__name string Organism name. Eg. `MUS_MUSCULUS`
    #' @param length string Short hand for `index_type` Eg. `short` or `long`
    #' @family transcriptome_indices

    rb_transcriptome_indices_list = function(salmon_version = NULL,
                                             index_type = NULL,
                                             ordering = NULL,
                                             limit = NULL,
                                             offset = NULL,
                                             organism__name = NULL,
                                             length = NULL) {
      args <- as.list(environment())
      get_by_endpoint("/transcriptome_indices/", query = args)
    }
  )
)
