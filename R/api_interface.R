make_request <- function(method, url, ...) {
    response <- httr::VERB(
        verb = method,
        url,
        ...,
        httr::content_type("application/json"),
        httr::add_headers("API-KEY" = rb_get_token()),
        verbose()
    )
    httr::stop_for_status(response)
    response
    to_keep <- c(
        "status_code",
        "headers",
        "date",
        "times",
        "request"
    )
    ret <- response[to_keep]
    body_parsed <- jsonlite::fromJSON(
        content(response, as = "text", encoding = "utf-8"),
        simplifyDataFrame = TRUE
    )
    if (!("results" %in% names(body_parsed))) {
        body_parsed <- list(results = body_parsed)
    }
    ret <- c(ret, body_parsed)
    # ret$results <- as.data.frame(do.call(rbind, ret$results))
    class(ret) <- c("rb_result", class(ret))
    ret
}

get_url <- function(url, query = NULL) {
    make_request("GET", url, query = query)
}

post_url <- function(url, body = NULL) {
    make_request("POST", url, body = body)
}

put_url <- function(url, body = NULL) {
    make_request("PUT", url, body = body)
}

make_url <- function(endpoint) {
    httr::modify_url(base_url, path = paste0("v1", endpoint))
}

get_by_endpoint <- function(endpoint, query = NULL) {
    url <- make_url(endpoint)
    get_url(url, query = query)
}

post_by_endpoint <- function(endpoint, body = NULL) {
    url <- make_url(endpoint)
    post_url(url, body = body)
}

put_by_endpoint <- function(endpoint, body = NULL) {
    url <- make_url(endpoint)
    put_url(url, body = body)
}
