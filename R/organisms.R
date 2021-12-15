#' List all available organisms from refine.bio
#'
#'
#' @returns a `data.frame` with four columns:
#'
#' - name
#' - taxonomy_id
#' - has_compendia
#' - has_quantfile_compendia
#'
#' @examples
#'
#' rb_orgs = rb_organisms()
#' head(rb_orgs)
#'
#' table(rb_orgs$has_compendia)
#' table(rb_orgs$has_quantfile_compendia)
#'
#' @export
rb_organisms <- function(client = RefineBio::RefineBio()) {
    res = rapiclient::get_operations(client)$organisms_list()
    ret = jsonlite::fromJSON(rawToChar(res$content))
    ret_df = ret$results
    # uses the "next" element from the response
    # to loop over all possible organisms
    while(TRUE) {
        # if there is no "next" url, return results
        if(!is.null(ret[['next']])) {
            res = httr::GET(ret[['next']])
            ret = jsonlite::fromJSON(rawToChar(res$content))
            ret_df = rbind(ret_df,ret$results)
        } else {
            return(ret_df)
        }
    }
}
