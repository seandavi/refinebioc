test_that("rb_platform_list returns a non-empty data frame", {
  # Test
  result <- rb_platform_list()

  # Assertion
  expect_true(is.data.frame(result))
  expect_gt(nrow(result), 0)
  expect_gt(ncol(result), 0)
})

test_that("rb_organism_list returns a non-empty data frame", {
  # Test
  result <- rb_organism_list()

  # Assertion
  expect_true(is.data.frame(result))
  expect_gt(nrow(result), 0)
  expect_gt(ncol(result), 0)
})

test_that("rb_institution_list returns a non-empty data frame", {
  # Test
  result <- rb_institution_list()

  # Assertion
  expect_true(is.data.frame(result))
  expect_gt(nrow(result), 0)
  expect_gt(ncol(result), 0)
})
