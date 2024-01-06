rb_dataset_check_state <- function(dataset_id) {
  response <- get_by_endpoint(sprintf("/dataset/%s/", dataset_id))
  return(response)
}

rb_dataset_is_processed <- function(dataset_id) {
  response <- rb_dataset_check_state(dataset_id)
  return(response$results$is_processed)
}

rb_dataset_is_available <- function(dataset_id) {
  response <- rb_dataset_check_state(dataset_id)
  return(response$results$is_available)
}

rb_dataset_is_processing <- function(dataset_id) {
  response <- rb_dataset_check_state(dataset_id)
  return(response$results$is_processing)
}

rb_dataset_is_ready <- function(dataset_id) {
  response <- rb_dataset_check_state(dataset_id)
  return(response$results$is_processed & response$results$is_available)
}


rb_wait_for_dataset <- function(dataset_id, seconds = 10) {
  while (!rb_dataset_is_ready(dataset_id)) {
    Sys.sleep(seconds)
  }
  return(dataset_id)
}

rb_dataset_download <- function(ID, base_path = ".") {
  response <- get_by_endpoint(sprintf("/dataset/%s/", ID))
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

rb_dataset_extract <- function(ID, base_path = ".") {
  zip_file <- rb_dataset_download(ID, base_path)
  unzip(zip_file, exdir = file.path(base_path, ID))
  return(file.path(base_path, ID))
}

rb_load_dataset <- function(ID, base_path = ".") {
  dataset_path <- rb_dataset_extract(ID, base_path)
  loaded <- dataset_loader(dataset_path)
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
  response <- post_by_endpoint("/dataset/", body = jbody)
  return(response$results)
}
