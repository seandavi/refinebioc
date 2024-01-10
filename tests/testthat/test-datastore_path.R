test_that("sets path to datastore when given valid path", {
  # Arrange
  valid_path <- file.path(tempdir(), "rb_datastore")

  # Act
  datastore_set_path(valid_path)

  # Assert
  expect_equal(getOption("refinebioc.datastore"), valid_path)
})


test_that("creates directory at given path if it does not exist", {
  # Arrange
  non_existing_path <- file.path(
    tempdir(),
    paste0(
      "non_existing_directory", "_",
      paste0(sample(LETTERS, 5), collapse = "")
    )
  )

  # Act
  datastore_set_path(non_existing_path)

  # Assert
  expect_true(dir.exists(non_existing_path))

  # Cleanup
  unlink(non_existing_path, recursive = TRUE)
})


test_that("raises error if given path is not a character", {
  # Arrange
  invalid_path <- 123

  # Act
  expect_error(datastore_set_path(invalid_path))
})


test_that("raises error if given path is not of length 1", {
  # Arrange
  invalid_path <- c("path1", "path2")

  # Act & Assert
  expect_error(datastore_set_path(invalid_path))
})
