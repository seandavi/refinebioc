#' Flatten a list
#'
#' Convert a list with multiple elements
#' into a flattened list keeping the names
#' of the original list
#'
#' @examples
#' a <- list(b = 1:5, d = LETTERS[1:3])
#'
flatten_list <- function(x) {
    repeat {
        if (!any(vapply(x, is.list, logical(1)))) {
            return(x)
        }
        x <- Reduce(c, x)
    }
}
