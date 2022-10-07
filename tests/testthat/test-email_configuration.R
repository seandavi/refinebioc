

test_that("setting and getting email works", {
  oldenv <-
    Sys.getenv("REFINEBIO_CONFIG_FILE")
  Sys.setenv(REFINEBIO_CONFIG_FILE = tempfile())
  email_address <- "this@example.com"
  set_email(email_address)
  expect_equal(get_email(), email_address)
  Sys.setenv(REFINEBIO_CONFIG_FILE = oldenv)
})

test_that("getting email results in error if not set and require_set==TRUE", {
  oldenv <-
    Sys.getenv("REFINEBIO_CONFIG_FILE")
  Sys.setenv(REFINEBIO_CONFIG_FILE = tempfile())
  expect_error(get_email(require_set = TRUE))
  Sys.setenv(REFINEBIO_CONFIG_FILE = oldenv)
})
