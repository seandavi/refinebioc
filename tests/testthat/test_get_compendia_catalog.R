test_result <- get_compendia_catalog()

test_that("Should return a tibble", {
    expect_s3_class(test_result, "data.frame")
})
