test_that("should return a browseable", {
  # Mock the dataset_id_from_args function
  .dataset_id_from_args <- function(dataset) {
    return(dataset)
  }

  # Mock the browseURL function
  browseURL <- function(url) {
  }

  # Call the function under test
  expect_equal(
    dataset_page_browser("valid_dataset_id"),
    "https://www.refine.bio/dataset/valid_dataset_id"
  )
})

test_that("should return a shareable link", {
  # Mock the dataset_id_from_args function
  .dataset_id_from_args <- function(dataset) {
    return(dataset)
  }

  # Call the function under test
  expect_equal(
    dataset_sharing_link("valid_dataset_id"),
    "https://www.refine.bio/dataset/valid_dataset_id?ref=share"
  )
})
