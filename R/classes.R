.dataset_id_from_args <- function(dataset) {
  if (is.null(dataset)) {
    stop("dataset_id is required")
  }
  if (is(dataset, "rb_dataset")) {
    dataset_id <- dataset$id
  } else {
    dataset_id <- dataset
  }
  return(dataset_id)
}

rb_dataset_update_state <- function(dataset) {
  dataset_id <- .dataset_id_from_args(dataset)
  response <- get_by_endpoint(sprintf("dataset/%s/", dataset_id))
  return(response$results)
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


rb_wait_for_dataset <- function(dataset, seconds = 10) {
  while (!rb_dataset_is_available(dataset)) {
    Sys.sleep(seconds)
  }
  return(TRUE)
}

rb_dataset_download <- function(ID, base_path = ".", overwrite = FALSE) {
  stopifnot(rb_dataset_is_available(ID))
  if (!overwrite && file.exists(file.path(base_path, paste0(ID, ".zip")))) {
    return(file.path(base_path, paste0(ID, ".zip")))
  }
  response <- get_by_endpoint(sprintf("dataset/%s/", ID))
  download_url <- response$results$download_url
  httr::GET(
    download_url,
    httr::progress(),
    httr::write_disk(file.path(
      base_path, paste0(ID, ".zip")
    ))
  )
  return(file.path(base_path, paste0(ID, ".zip")))
}

rb_dataset_extract <- function(ID, base_path = ".", overwrite = FALSE) {
  if (file.exists(file.path(
    base_path, ID, "aggregated_metadata.json"
  )) && !overwrite) {
    return(file.path(base_path, ID))
  }
  zip_file <- rb_dataset_download(ID, base_path)
  unzip(zip_file, exdir = file.path(base_path, ID), overwrite = TRUE)
  return(file.path(base_path, ID))
}

rb_load_dataset <- function(
    ID, base_path = ".", cache_result = TRUE,
    overwrite = FALSE) {
  if (!overwrite && file.exists(file.path(base_path, paste0(ID, ".rds")))) {
    return(readRDS(file.path(base_path, paste0(ID, ".rds"))))
  }
  dataset_path <- rb_dataset_extract(ID, base_path, overwrite)
  loaded <- dataset_loader(dataset_path)
  if (cache_result) {
    saveRDS(loaded, file = file.path(base_path, paste0(ID, ".rds")))
  }
  return(loaded)
}



rb_dataset_request <- function(
    studies,
    quantile_normalize = FALSE,
    quant_sf_only = FALSE,
    svd_algorithm = "NONE",
    scale_by = "NONE",
    aggregate_by = "EXPERIMENT",
    notify_me = FALSE,
    start = TRUE) {
  data <- setNames(as.list(rep("ALL", length(studies))), studies)
  body <- list()
  body$data <- data
  body$email_address <- jsonlite::unbox(
    get_rb_email_address(required = TRUE)
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


setOldClass("rb_dataset")
setMethod("print", "rb_dataset", function(x) {
  .print_rb_dataset(x)
})

setMethod("show", "rb_dataset", function(object) {
  .print_rb_dataset(object)
})
