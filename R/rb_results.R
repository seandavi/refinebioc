#' This is my RefineBioResults class
#' @description  class description
#' @field name Name of the person
#' @field hair Hair colour
#'
#' @examples
#' r <- RefineBioResults$new(endpoint = "/experiments", method = "get")
#' r$next_page()$results
#' @export
RefineBioResults <- R6::R6Class(
    "RefineBioResults",
    private = list(
        status_code = NULL,
        headers = NULL,
        date = NULL,
        times = NULL,
        query = NULL,
        body = NULL,
        method = NULL,
        endpoint = NULL,
        request = NULL,
        count = NULL,
        limit = 50,
        offset = 0,
        .results = NULL,
        get_results = function(limit = private$limit,
                               offset = private$offset) {
            query <- c(private$query, list(limit = limit, offset = offset))
            response <- make_request(
                private$method,
                url = make_url(private$endpoint),
                query = query,
                body = private$body
            )
            private$count <- response$count
            private$times <- response$times
            private$date <- response$date
            private$.results <- response$results
            private$offset <- private$offset + nrow(response$results)
            private$headers <- response$headers
            return(response$results)
        }
    ),
    public = list(
        initialize = function(query = NULL,
                              body = NULL,
                              method = NULL,
                              endpoint = NULL,
                              limit = 50,
                              offset = 0) {
            private$query <- query
            private$body <- body
            private$method <- method
            private$endpoint <- endpoint
            private$limit <- limit
            private$offset <- offset
            z <- private$get_results(0, 0)
        },
        reset_cursor = function() {},
        has_next = function() {
            private$count > private$offset
        },
        next_results = function() {
            private$get_results()
        },
        all_results = function() {
            private$offset <- 0 # TODO: exchange for reset
            results <- private$get_results()
            pb <- progress_bar$new(
                format = "(:spin) [:bar] :percent [Elapsed time: :elapsedfull || Estimated time remaining: :eta]",
                total = floor(private$count / private$limit) + 1,
                complete = "=", # Completion bar character
                incomplete = "-", # Incomplete bar character
                current = ">", # Current bar character
                clear = FALSE, # If TRUE, clears the bar when finish
                width = 100
            )
            # TODO: quiet status bar if not interactive
            # TODO: add sleep if getting a 429
            pb$tick()
            while (self$has_next()) {
                results <- rbind(results, private$get_results())
                pb$tick()
            }
            return(results)
        }
    )
)
