#' Get data from RefineBio
#'
#' @param studies A list of study ids to download.
#' @param email_address The email address to send the download link to and
#' required to download the data.
#' @param quantile_normalize Whether to quantile normalize the data.
#' @param quant_sf_only Whether to only quantile normalize the signal fraction.
#' @param svd_algorithm The algorithm to use for SVD.
#' @param scale_by The scale factor to use for scaling the data.
#' @param aggregate_by The aggregation method to use for the data.
#'
#' @return A list of [SummaryExperiment::SummarizedExperiment] objects.
#'
#' @examples
#' \dontrun{
#' selist <- get_refinebio(c("GSE34126", "SRP113332"), email_address = "email@myemail.com")
#' }
#'
#' @export
get_refinebio <- function(studies, email_address, quantile_normalize = NULL,
                          quant_sf_only = NULL, svd_algorithm = NULL,
                          scale_by = NULL, aggregate_by = NULL) {
    dataset <- Dataset$new(studies, email_address, quantile_normalize, quant_sf_only, svd_algorithm, scale_by, aggregate_by)
    dataset$save()$start_processing()$wait_until_ready()$download()$extract()$create_summarized_experiment_from_extract()
}
