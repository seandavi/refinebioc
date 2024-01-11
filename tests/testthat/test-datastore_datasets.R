TEST_DATASET_ID <- "32ce33c0-a528-4e14-8224-17bc980409cc"

test_that("returns an empty list when no datasets are found in the base path", {
    # Set up
    base_path <- system.file(
        "testdata/datastore",
        package = "RefineBio"
    )

    # Test
    result <- datastore_datasets(base_path)

    # Assertion
    expect_equal(result, TEST_DATASET_ID)
})
