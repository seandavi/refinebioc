#' Retrieves a DownloaderJob by ID
#' @param id integer A unique integer value identifying this downloader job. (required)


#' @family jobs


rb_jobs_downloader_read <- function(
    id
)

{
    args = as.list(environment())
    client = rb_get_client()
    res = .process_json_result(
        do.call(rapiclient::get_operations(client)$jobs_downloader_read,args)
        )
    res$facets = lapply(res$facets,.facet_to_data_frame)
    res
}
