# Config variables
# - email
# - token
# - agree_to_terms
# - refinebio_path
# - configfile
rb_data_path <- function() {
    p <- file.path(tempdir(), "rb_data_path")
    if (!dir.exists(p)) {
        dir.create(p)
    }
    return(p)
}

rb_email_address <- function() {
    return(whoami::email_address())
}
