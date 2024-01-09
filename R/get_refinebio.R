get_refinebio <- function(experiment) {
  ds <- rb_dataset_request(
    studies = experiment
  )
  logger::log_info("Registered dataset request: ", ds$id)
  logger::log_info("Starting to wait for RefineBio to process: ", ds$id)
  rb_wait_for_dataset(ds)
  logger::log_info("RefineBio finished processing: ", ds$id)
  logger::log_info("Dataset available: ", ds$id)
  logger::log_info("Starting to download: ", ds$id)
  rb_dataset_download(ds)
  logger::log_info("Dataset downloaded: ", ds$id)
  logger::log_info("Starting to extract: ", ds$id)
  rb_dataset_extract(ds)
  logger::log_info("Dataset extracted: ", ds$id)
  loaded_dataset <- rb_dataset_load(ds)
  logger::log_info("Dataset loaded: ", ds$id)

  return(loaded_dataset)
}
