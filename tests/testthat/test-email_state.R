test_that("returns email address if set in environment or options", {
  # Set up
  set_rb_email_address("test@example.com")

  # Test
  result <- get_rb_email_address()

  # Assertion
  expect_equal(result, "test@example.com")
})

test_that(paste(
  "returns NA if email address is not set",
  "and required parameter is set to FALSE"
), {
  # Set up
  options(RB_EMAIL_ADDRESS = NULL)
  Sys.unsetenv("RB_EMAIL_ADDRESS")

  # Test
  result <- get_rb_email_address(required = FALSE)

  # Assertion
  expect_equal(result, NA)
})


test_that(paste(
  "does not throw an error if email address",
  "is not set and required parameter is set to FALSE"
), {
  # Set up
  options(RB_EMAIL_ADDRESS = NULL)
  Sys.unsetenv("RB_EMAIL_ADDRESS")

  # Test and assertion
  expect_no_error(get_rb_email_address(required = FALSE))
})


test_that("when setting email, throw an error if not a character string", {
  # Test and assertion
  expect_error(set_rb_email_address(234))
})


test_that(paste(
  "returns the email address set in option",
  "variable even if environment variable is also set"
), {
  # Set up
  options(RB_EMAIL_ADDRESS = "option@example.com")
  Sys.setenv(RB_EMAIL_ADDRESS = "environment@example.com")

  # Test
  result <- get_rb_email_address()

  # Assertion
  expect_equal(result, "option@example.com")
})


test_that("email set in environment variable works", {
  # Set up
  options(RB_EMAIL_ADDRESS = NULL)
  Sys.setenv(RB_EMAIL_ADDRESS = "environment@example.com")

  # Test
  result <- get_rb_email_address()

  # Assertion
  expect_equal(result, "environment@example.com")
})

test_that("email set in option variable works", {
  # Set up
  options(RB_EMAIL_ADDRESS = "option@example.com")
  Sys.unsetenv("RB_EMAIL_ADDRESS")

  # Test
  result <- get_rb_email_address()

  # Assertion
  expect_equal(result, "option@example.com")
})
