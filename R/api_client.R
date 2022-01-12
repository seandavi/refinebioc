.rb_environment <- new.env(parent=emptyenv())


#' Low level api client accessor
#'
#' This function is an accessor for the
#' [refine.bio API](https://api.refine.bio).
#' On first access, the rapiclient-based client
#' will be built and returned. On subsequent calls,
#' the client will be fetched from an environment-based
#' cache.
#'
#'
#' @param url character(1) the url of the refine bio API root, default
#' `.refinebio_url`
#'
#' @param ... passed directly to [rapiclient::get_api()]
#' @param renew logical(1) TRUE to reconnect and rebuild API client,
#'
#'
#' @seealso [rapiclient::get_api()]
#'
#' @family low-level-api
#'
#' @examples
#'
#' client = RefineBio()
#'
#' # operations
#' ops = rapiclient::get_operations(client)
#'
#'
#'
#' @export
rb_get_client <- function(url=.refinebio_url,renew=FALSE,...) {
    client = NULL
    if(renew || is.null(.rb_environment[['client']])) {
        client <- rapiclient::get_api(url,...)
        .rb_environment[['client']] <- client
    }
    .rb_environment[['client']]
}
