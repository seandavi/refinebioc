#' Create or get an active API token for use in downloading from the API
#'
#' The API token mechanism that refine.bio uses is relatively simple.
#' There is no "authentication" per se, just an acknowledgement of
#' agreement to terms and conditions of use. The token is only needed
#' for download of data.
#'
#' @details
#' Upon calling this function the first time in a session, if a token
#' is successfully obtained and activated, it will be stored in the session
#' in memory. Further calls will use the cached value. A new R session will
#' result in a new API token.
#'
#' @param activate logical(1) Setting to `TRUE` implies agreement with
#'   the refine.bio terms of service for downloading.
#'
#' @param quiet logical(1) Setting to `FALSE` will message the complete
#'   text of the terms of services.
#'
#' @export
rb_get_token <- function(activate=TRUE, quiet=TRUE) {
    if(!activate) {
        warning('Running this function without `activate=TRUE` will not generate a token')
    }
    if(!is.null(.rb_environment[['token']])) {
        return(.rb_environment[['token']])
    }
    # new token
    r = httr::content(httr::POST('https://api.refine.bio',path='/v1/token/'))
    if(!quiet) {
        message(r$terms_and_conditions)
    }
    # activate
    r = httr::content(httr::PUT('https://api.refine.bio',
                                 path=sprintf('/v1/token/%s/',r$id),
                                 body = list(is_activated=TRUE),
                                encode = 'json'))
    if(!r$is_activated) {
        stop('There was a problem obtaining or activating a token')
    }
    .rb_environment[['token']] = r$id
    r$id
}
