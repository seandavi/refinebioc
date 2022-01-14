#' Retrieves a DownloaderJob by ID
#' @family jobs
#' @export
rb_jobs_downloader_read <- function(

)

{
    args = as.list(environment())
    client = rb_get_client()
    token = rb_get_token()
    operation = rapiclient::get_operations(client)$jobs_downloader_read
    if(!is.null(token)) {
        headers = c('API-KEY'=token)
        operation = rapiclient::get_operations(client,.headers=headers)$jobs_downloader_read
    }
    res = .process_json_result(
        do.call(operation,args)
        )
    res
}
