TEST_PAGE_COUNT <- 2

test_result <- get_experiment_catalog(.pages = TEST_PAGE_COUNT)

test_that("Should return a tibble", {
  expect_s3_class(test_result, "tbl_df")
})

test_that(sprintf(
  "Should return a tibble with %d rows",
  TEST_PAGE_COUNT * 1000
), {
  expect_equal(nrow(test_result), TEST_PAGE_COUNT * 1000)
})

test_that("Should return a tibble with 21 columns", {
  expect_equal(ncol(test_result), 21)
})
