.dataset_id_from_args <- function(dataset) {
  if (is.null(dataset)) {
    stop("dataset_id is required")
  }
  if (methods::is(dataset, "rb_dataset")) {
    dataset_id <- dataset$id
  } else {
    dataset_id <- dataset
  }
  return(dataset_id)
}


#' Get the state of a dataset
#'
#' This function simply calls the API to get the state of a dataset.
#'
#' @param dataset The dataset ID or `rb_dataset` object
#'
#' @return A `rb_dataset` object, now with updated state.
rb_dataset_update_state <- function(dataset) {
  dataset_id <- .dataset_id_from_args(dataset)
  response <- get_by_endpoint(sprintf("dataset/%s/", dataset_id))

  ret <- structure(response$results,
    class = c("rb_dataset", class(response$results))
  )
  return(ret)
}

rb_dataset_is_processed <- function(dataset) {
  res <- rb_dataset_update_state(dataset)
  return(res$is_processed)
}

rb_dataset_is_available <- function(dataset) {
  res <- rb_dataset_update_state(dataset)
  return(res$is_available)
}

rb_dataset_is_processing <- function(dataset) {
  res <- rb_dataset_update_state(dataset)
  return(res$is_processing)
}

rb_dataset_is_available <- function(dataset) {
  res <- rb_dataset_update_state(dataset)
  return(res$is_available)
}

#' Wait for a dataset to become available
#'
#' @param dataset The dataset ID or `rb_dataset` object
#' @param seconds The number of seconds to wait between checks
#'
#' @return The dataset object when it is available
wait_for_dataset <- function(dataset, seconds = 10) {
  start_time <- Sys.time()
  rb_dataset_ensure_started(dataset)
  while (!rb_dataset_is_available(dataset)) {
    logger::log_info(
      sprintf(
        "Waiting for dataset availability (%f seconds elapsed)...",
        difftime(Sys.time(), start_time, units = "secs")
      )
    )
    Sys.sleep(seconds)
  }
  return(dataset)
}

#' Download an available dataset from refine.bio
#'
#' Note that the dataset must be available before it can be downloaded.
#'
#' @param ID The dataset ID
#' @param base_path The path to the directory where the dataset will be
#' downloaded and extracted.
#' @param overwrite If TRUE, overwrite the cached result.
#'
#' @return The path to the downloaded zipfile.
download_dataset <- function(
    dataset,
    base_path = datastore_get_path(),
    overwrite = FALSE) {
  dataset_id <- .dataset_id_from_args(dataset)
  stopifnot(rb_dataset_is_available(dataset_id))
  if (!overwrite && file.exists(file.path(
    base_path, paste0(dataset_id, ".zip")
  ))) {
    return(file.path(base_path, paste0(dataset_id, ".zip")))
  }
  response <- get_by_endpoint(sprintf("dataset/%s/", dataset_id))
  download_url <- response$results$download_url
  httr::GET(
    download_url,
    httr::progress(),
    httr::write_disk(file.path(
      base_path, paste0(dataset_id, ".zip")
    ))
  )
  return(file.path(base_path, paste0(dataset_id, ".zip")))
}


#' Extract a downloaded dataset zipfile
#'
#' @param ID The dataset ID
#' @param base_path Path to the directory where the zipfile will be extracted.
#' @param overwrite If TRUE, overwrite the existing directory.
#'
#' @return The path to the extracted directory.
extract_dataset <- function(
    dataset,
    base_path = datastore_get_path(),
    overwrite = FALSE) {
  dataset_id <- .dataset_id_from_args(dataset)
  if (file.exists(file.path(
    base_path, dataset_id, "aggregated_metadata.json"
  )) && !overwrite) {
    return(file.path(base_path, dataset_id))
  }
  zip_file <- file.path(base_path, paste0(dataset_id, ".zip"))
  utils::unzip(
    zip_file,
    exdir = file.path(base_path, dataset_id), overwrite = overwrite
  )
  # TODO: consider gzipping the tsv and json files
  # The readers will all deal with the gz files just fine.
  return(file.path(base_path, dataset_id))
}

#' Load a dataset from a refinebio download
#'
#' @param ID The dataset ID
#' @param base_path The path to the directory where the dataset will be
#'  downloaded and extracted.
#' @param cache_result If TRUE, cache the result in the base_path.
#' @param overwrite If TRUE, overwrite the cached result.
#'
#' @return A list of `SummarizedExperiment`s representing the
#'  experiments in the RefineBio downloaded dataset.
#'
#' @export
load_dataset <- function(
    dataset, base_path = datastore_get_path(), use_caching = TRUE) {
  dataset_id <- .dataset_id_from_args(dataset)
  dataset_path <- file.path(base_path, dataset_id)
  rds_name <- file.path(dataset_path, paste0(dataset_id, ".rds"))
  if (use_caching && file.exists(rds_name)) {
    return(readRDS(rds_name))
  }
  loaded <- extract_local_dataset(dataset_path)
  if (use_caching) {
    saveRDS(loaded, file = rds_name)
  }
  return(loaded)
}


submit_dataset_request <- function(
    studies,
    quantile_normalize = FALSE,
    quant_sf_only = FALSE,
    svd_algorithm = "NONE",
    scale_by = "NONE",
    aggregate_by = "EXPERIMENT",
    notify_me = FALSE,
    start = FALSE) {
  data <- stats::setNames(as.list(rep("ALL", length(studies))), studies)
  body <- list()
  body$data <- data
  body$email_address <- jsonlite::unbox(
    rb_email_address()
  )
  body$quant_sf_only <- jsonlite::unbox(quant_sf_only)
  body$quantile_normalize <- jsonlite::unbox(quantile_normalize)
  body$svd_algorithm <- jsonlite::unbox(svd_algorithm)
  body$scale_by <- jsonlite::unbox(scale_by)
  body$aggregate_by <- jsonlite::unbox(aggregate_by)
  body$notify_me <- jsonlite::unbox(notify_me)
  body$start <- jsonlite::unbox(start)
  jbody <- jsonlite::toJSON(body)
  response <- post_by_endpoint("dataset/", body = jbody)
  ret <- structure(response$results,
    class = c("rb_dataset", class(response$results))
  )
  return(ret)
}


.print_rb_dataset <- function(x) {
  cat(sprintf("rb_dataset <%s>", x$id))
  for (i in c("is_processed", "is_available", "is_processing")) {
    cat(sprintf("\n%s: %s", i, x[[i]]))
  }
  cat(sprintf("\nsample count: %d", length(unlist(x$data))))
  cat(sprintf("\nstudies: %s", names(x$data)))
}

rb_dataset_ensure_started <- function(dataset) {
  dataset_id <- .dataset_id_from_args(dataset)
  logger::log_debug("Ensuring dataset is started: ", dataset_id)
  current <- rb_dataset_update_state(dataset)
  if (current$is_processing || current$is_processed) {
    return(current)
  }
  body <- list()
  body$data <- current$data
  body$quant_sf_only <- jsonlite::unbox(current$quant_sf_only)
  body$quantile_normalize <- jsonlite::unbox(current$quantile_normalize)
  body$svd_algorithm <- jsonlite::unbox(current$svd_algorithm)
  body$email_address <- jsonlite::unbox(rb_email_address())
  body$scale_by <- jsonlite::unbox(current$scale_by)
  body$aggregate_by <- jsonlite::unbox(current$aggregate_by)
  body$notify_me <- jsonlite::unbox(current$notify_me)
  body$start <- jsonlite::unbox(TRUE)
  jbody <- jsonlite::toJSON(body)
  response <- put_by_endpoint(
    sprintf("dataset/%s/", dataset_id),
    body = jbody
  )
  ret <- structure(response$results,
    class = c("rb_dataset", class(response$results))
  )
  return(ret)
}


setOldClass("rb_dataset")
setMethod("print", "rb_dataset", function(x) {
  .print_rb_dataset(x)
})

setMethod("show", "rb_dataset", function(object) {
  .print_rb_dataset(object)
})
