test_that("config file naming works without environment variable", {
  filename <- config_file()
  oldenv <- Sys.getenv("REFINEBIO_CONFIG_FILE")

  expect_equal(
    config_file(),
    file.path(rappdirs::user_config_dir("RefineBio"), "config.yaml")
  )

  Sys.setenv(REFINEBIO_CONFIG_FILE = oldenv)
})

test_that("config file creation works with environment variable", {
  tmpfile <- tempfile()
  oldenv <- Sys.getenv("REFINEBIO_CONFIG_FILE")
  Sys.setenv(REFINEBIO_CONFIG_FILE = tmpfile)
  expect_equal(tmpfile, config_file())
  Sys.setenv(REFINEBIO_CONFIG_FILE = oldenv)
})
