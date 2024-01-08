#' Helper function for getting entity lists
#'
#' @param endpoint `character(1)` The endpoint to get data from.
#' @param paginate `logical(1)` Whether to paginate through the results.
#'
#' @return `data.frame` The results of the query.
#'
#' @keywords internal
#' @family refine.bio API
#'
#' @author Sean Davis <seandavi@gmail.com>
#'
#' @examples
#' \dontrun{
#' rb_entity_list("platforms", paginate = FALSE)
#' }
rb_entity_list <- function(endpoint, paginate) {
  stopifnot(is.logical(paginate))
  stopifnot(is.character(endpoint))
  stopifnot(endpoint %in% c(
    "platforms", "organisms", "institutions", "compendia"
  ))
  offset <- 0
  res <- get_by_endpoint(endpoint,
    query = list(limit = 1000, offset = offset)
  )
  if (paginate) {
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
  } else {
    return(res$results)
  }
}

#' All available platforms in refine.bio
#'
#' @return `data.frame` All available platforms.
#'
#' @author Sean Davis <seandavi@gmail.com>
#'
#' @family refine.bio API
#'
#' @examples
#' platforms <- rb_platform_list()
#' head(platforms)
#'
#' @export
rb_platform_list <- function() {
  return(rb_entity_list("platforms", paginate = FALSE))
}

#' All available organisms in refine.bio
#'
#' @author Sean Davis <seandavi@gmail.com>
#'
#' @family refine.bio API
#'
#' @return `data.frame` All available organisms.
#'
#' @examples
#' orgs <- rb_organism_list()
#' head(orgs)
#'
#' @export
rb_organism_list <- function() {
  return(rb_entity_list("organisms", paginate = FALSE))
}

#' All available institutions in refine.bio
#'
#' @return `data.frame` All available submitter institutions.
#'
#' @author Sean Davis <seandavi@gmail.com>
#'
#' @family refine.bio API
#'
#' @examples
#' insts <- rb_institution_list()
#' head(insts)
#'
#' @export
rb_institution_list <- function() {
  return(rb_entity_list("institutions", paginate = FALSE))
}

#' All available compendia in refine.bio
#'
#' This function returns a list of all available compendia in refine.bio.
#'
#' @details
#'
#' We periodically release compendia comprised of
#' all the samples from a species that we were able to process.
#' We refer to these as refine.bio compendia.
#' We offer two kinds of refine.bio compendia:count
#' - [Normalized compendia](https://docs.refine.bio/en/latest/main_text.html#normalized-compendia)
#' - [RNA-seq compendia](https://docs.refine.bio/en/latest/main_text.html#rna-seq-sample-compendia)
#'
#' Both types of compendia are available for download
#' from the [RefineBio website](https://www.refine.bio/).
#' The details of how these compendia are generated are described in
#' the [RefineBio site documentation](https://docs.refine.bio/en/latest/main_text.html#compendia)
#' and summarized here for convenience.
#'
#' ## Normalized compendia
#'
#' Refine.bio normalized compendia are comprised of all the samples
#' from a species that we were able to process, aggregate, and normalize.
#' Normalized compendia provide a snapshot of the most complete
#' collection of gene expression that refine.bio can produce for
#' each supported organism.
#' They process these compendia in a manner that is different from
#'  the options that are available via the web user interface.
#' Note that submitter processed samples that are available through the
#'  web user interface are omitted from normalized compendia because
#'  these samples can introduce unwanted technical variation.
#'
#' The refine.bio web interface does an inner join when datasets are
#'  combined, so only genes present in all datasets are
#'  included in the final matrix.
#' For compendia, they take the union of all genes,
#' filling in any missing values with NA.
#' This is a “full outer join” as illustrated in the
#' [RefineBio site documentation](https://docs.refine.bio/en/latest/main_text.html#normalized-compendia).
#' They use a full outer join because it allows us to
#'  retain more genes in a compendium and then impute
#'  missing values during compendia creation.
#'
#' ## RNA-seq sample compendia
#'
#' refine.bio RNA-seq sample compendia are comprised of the Salmon
#' output for the collection of RNA-seq samples from an organism
#' that we have processed with refine.bio.
#' Each individual sample has its own quant.sf file; the
#' samples have not been aggregated and normalized.
#' RNA-seq sample compendia are designed to allow users that
#' are comfortable handling these files to generate output
#' that is most useful for their downstream applications.
#' Please see the Salmon documentation on the quant.sf
#' output format for more information.
#'
#' @return `data.frame` The results of the query.
#'
#' @author Sean Davis <seandavi@gmail.com>
#'
#' @examples
#' # note that the download links are specific to my account
#' # and will not work for you.
#' compendia <- rb_compendia_list()
#'
#' colnames(compendia)
#'
#' head(compendia)
#'
#' @family refine.bio API
#' @family compendia
#'
#' @export
rb_compendia_list <- function() {
  return(rb_entity_list("compendia", paginate = FALSE))
}
