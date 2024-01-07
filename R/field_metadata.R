#' All available platforms in refine.bio
#'
#' @examples
#' platforms <- rb_platform_list()
#' head(platforms)
#'
#' @export
rb_platform_list <- function() {
  result <- get_by_endpoint("platforms")$results
  return(result)
}

#' All available organisms in refine.bio
#'
#' @examples
#' orgs <- rb_organism_list()
#' head(orgs)
#'
#' @export
rb_organism_list <- function() {
  offset <- 0
  res <- get_by_endpoint("organisms",
    query = list(limit = 1000, offset = offset)
  )
  count <- res$count
  results <- res$results
  while (offset < count) {
    offset <- offset + 1000
    new_results <- get_by_endpoint("organisms",
      query = list(limit = 1000, offset = offset)
    )$results
    results <- dplyr::bind_rows(results, new_results)
  }
  return(results)
}

#' All available institutions in refine.bio
#'
#' @examples
#' insts <- rb_institution_list()
#' head(insts)
#'
#' @export
rb_institution_list <- function() {
  result <- get_by_endpoint("institutions")$results
  return(result)
}
