#' configuration
#'
#' @rdname configuration
NULL

#' @rdname configuration
config_file <- function() {
    if (Sys.getenv("REFINEBIO_CONFIG_FILE") != "") {
        filename <- Sys.getenv("REFINEBIO_CONFIG_FILE")
    } else {
        filename <-
            file.path(rappdirs::user_config_dir("RefineBio"), "config.yaml")
    }

    dir.create(dirname(filename), showWarnings = FALSE)
    filename
}

.list_value_exists_and_not_null <- function(l, element) {
    if (!(element %in% names(l))) {
        stop(sprintf("The %s must be set", element))
    }
    if (is.null(l[[element]])) {
        stop(sprintf("The %s must be set", element))
    }
    TRUE
}

#' @describedIn configuration
get_config <- function() {
    if (!file.exists(config_file())) {
        return(list())
    }
    config <- yaml::read_yaml(config_file())
    return(config)
}

#' @rdname configuration
set_config <- function(name, value) {
    config <- get_config()
    config[[name]] <- value
    yaml::write_yaml(config, config_file())
}

#' @rdname configuration
set_email <- function(email) {
    set_config("email", email)
}

#' @describedIn configuration
get_email <- function(require_set = FALSE) {
    config <- get_config()
    if (require_set) {
        .list_value_exists_and_not_null(config, "email")
    }
    return(config$email)
}
