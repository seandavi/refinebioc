#' internal function to get the email address for the current session
#'
#'   \if{html}{\figure{mai.png}{options: width="100\%" alt="Figure: mai.png"}}
#'
#' @export
.rb_get_email_address <- function() {
  option_email <- getOption("RB_EMAIL_ADDRESS", NA)
  if (!is.na(option_email)) {
    return(option_email)
  }
  env_email <- Sys.getenv("RB_EMAIL_ADDRESS", NA)
  if (!is.na(env_email)) {
    return(env_email)
  }
  email <- whomai::email_address()
  if (email != "" && !is.na(email)) {
    return(email)
  }
  return(NA)
}

#' get the email address for the current session
#'
#' @examples
#' \dontrun{
#' get_rb_email_address()
#' }
#'
#' @export
rb_email_address <- function() {
  email_address <- .rb_get_email_address()
  if (is.na(email_address)) {
    stop(paste(
      "email address is not set in environment or options.",
      "Use set_rb_email_address() to set it."
    ))
  }
  return(email_address)
}

#' set the email address for the current session
#'
#' @param email_address character string
#'
#' @examples
#' \dontrun{
#' set_rb_email_address("happy_rb_user@example.com")
#' }
#'
#' @export
rb_set_email_address <- function(email_address) {
  if (!is.character(email_address)) {
    stop("email_address must be a character string")
  }
  options(RB_EMAIL_ADDRESS = email_address)
  invisible(email_address)
}
