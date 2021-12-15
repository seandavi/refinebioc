#' List all available platforms from refine.bio
#'
#'
#' @returns a 2-column `data.frame`
#'
#' @examples
#'
#' plats = rb_platforms()
#' head(plats)
#'
#' @export
rb_platforms <- function(client = RefineBio::RefineBio()) {
    res = rapiclient::get_operations(client)$platforms_list()
    ret = jsonlite::fromJSON(rawToChar(res$content))
    ret
}
