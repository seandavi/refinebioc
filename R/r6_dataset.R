require(R6)




#' R6 Class representing a person.
#' @description This is a new description line
#'
#' @details
#' A person has a name and a hair color.
#'
#' This is a third line.
#'
#' # Usage
#'
#' ```
#' d = Dataset$new(studies="GSE34126")
#' d$email_address = 'your_email@ex.com'
#' d$save()$start_processing()$wait_until_ready()$download()
#' ```
#'
#' @export
Dataset <- R6::R6Class(
    "Dataset",
    public = list(
        id = NULL,
        data = NULL,
        aggregate_by = NULL,
        scale_by = NULL,
        quantile_normalize = NULL,
        quant_sf_only = NULL,
        svd_algorithm = NULL,
        email_address = NULL,

        #' @description
        #' Create a new [RefineBio::Dataset]
        #'
        #' @param studies a character() vector
        #' of experiments or studies to include in the dataset (eg., GSE346126)
        #'
        #' @return A new [RefineBio::Dataset$new()] object.
        initialize = function(studies, email_address, quantile_normalize = NULL,
                              quant_sf_only = NULL, svd_algorithm = NULL,
                              scale_by = NULL, aggregate_by = NULL) {
            self$id <- NULL
            self$data <- setNames(as.list(rep("ALL", length(studies))), studies)
            self$quantile_normalize <- quantile_normalize
            self$quant_sf_only <- quant_sf_only
            self$svd_algorithm <- svd_algorithm
            self$scale_by <- scale_by
            self$email_address <- email_address
            self$aggregate_by <- aggregate_by
        },
        run_pipeline = function() {
            self$save()$start_processing()$wait_until_ready()$download()$extract()
            return(self)
        },
        save = function() {
            body <- list()
            body$data <- self$data
            body$email_address <- jsonlite::unbox(self$email_address)
            transfer_categories <- c(
                "aggregate_by",
                "scale_by",
                "email_ccdl_ok",
                "start",
                "quantile_normalize",
                "quant_sf_only",
                "svd_algorithm",
                "notify_me"
            )
            for (i in transfer_categories) {
                if (!is.null(private[[i]])) {
                    body[[i]] <- unbox(private[[i]])
                }
            }
            print(body)
            if (!is.null(self$id)) {
                response <- put_by_endpoint(
                    paste0("/dataset/", self$id, "/"),
                    body = jsonlite::toJSON(body)
                )
            } else {
                response <- post_by_endpoint("/dataset/", body = jsonlite::toJSON(body))
            }
            self$id <- response$results$id
            self$data <- response$results$data
            private$is_processing <- response$results$is_processing
            private$is_processed <- response$results$is_processed
            invisible(self)
        },
        start_processing = function() {
            if (private$is_processing | private$is_processed) {
                return(self)
            }
            private$start <- TRUE
            invisible(self$save())
        },

        #' @description
        #' Change hair color.
        #' @param val New hair color.
        #' @examples
        #' P <- Person("Ann", "black")
        #' P$hair
        #' P$set_hair("red")
        #' P$hair
        set_id = function(val) {
            self$id <- val
        },
        update = function() {
            invisible(private$GET())
        },
        wait_until_ready = function(seconds = 10) {
            while (!private$is_processed) {
                Sys.sleep(seconds)
                self$update()
            }
            invisible(self)
        },
        download = function(base_path = ".") {
            if (private$is_processed & !is.null(private$download_url)) {
                httr::GET(
                    private$download_url,
                    httr::progress(),
                    httr::write_disk(file.path(base_path, paste0(self$id, ".zip")))
                )
                private$local_file <- file.path(base_path, paste0(self$id, ".zip"))
            }
            invisible(self)
        },
        extract = function(base_path = ".") {
            extract_directory <- file.path(base_path, self$id)
            if (private$is_processed & !is.null(private$download_url)) {
                unzip(private$local_file, exdir = extract_directory)
                private$extract_directory <- extract_directory
            }
        }
    ),
    private = list(
        is_processing = NULL,
        is_processed = NULL,
        is_available = NULL,
        has_email = NULL,
        email_ccdl_ok = NULL,
        notify_me = NULL,
        expires_on = NULL,
        s3_bucket = NULL,
        s3_key = NULL,
        success = NULL,
        failure_reason = NULL,
        created_at = NULL,
        last_modified = NULL,
        start = NULL,
        size_in_bytes = NULL,
        sha1 = NULL,
        download_url = NULL,
        local_file = NULL,
        GET = function() {
            response <- get_by_endpoint(sprintf("/dataset/%s/", self$id))
            for (k in names(response$results)) {
                if (k %in% names(private)) {
                    private[[k]] <- response$results[[k]]
                }
            }
            return(self)
        }
    )
)
