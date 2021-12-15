#' Low level api client
#'
#' This function is an accessor for the
#' [refine.bio API](https://api.refine.bio).
#'
#' @param url character(1) the url of the refine bio API root, default
#' `.refinebio_url`
#'
#' @param ... passed directly to [rapiclient::get_api()]
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
#' ops = rapiclient::operations(client)
#'
#'
#'
#' @export
RefineBio <- function(url=.refinebio_url,...) {
    client <- rapiclient::get_api(url,...)
    return(client)
}
