#' process the httr json response
#'
#' @param result [httr::response] object with body assumed to be json
#' @param encoding character(1) the encoding passed to [httr::content()]
#'
#' @keywords internal
.process_json_result <- function(result, encoding="UTF-8",...) {
    jsonlite::fromJSON(
        httr::content(
            result,
            type="text",
            encoding=encoding
        )
    )
}
