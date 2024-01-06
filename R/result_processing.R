.facet_to_data_frame <- function(l) {
  tmp <- unlist(l)
  return(data.frame(category = names(tmp), count = tmp))
}

#' process the httr json response
#'
#' @param result [httr::response] object with body assumed to be json
#' @param encoding character(1) the encoding passed to [httr::content()]
#'
#' @keywords internal
.process_json_result <- function(result, encoding = "UTF-8", ...) {
  res <- jsonlite::fromJSON(
    httr::content(
      result,
      type = "text",
      encoding = encoding
    )
  )
  if (is.data.frame(res)) {
    return(res)
  }
  if (is.list(res)) {
    if ("facets" %in% names(res)) {
      res$facets <- lapply(res$facets, .facet_to_data_frame)
    }
  }
  return(res)
}
