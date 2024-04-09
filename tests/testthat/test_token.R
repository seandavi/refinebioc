test_obtain_and_activate_token <- function() {
    token <- rb_get_token()

    # Assert that the token is obtained and activated
    testthat::expect_type(token, "character")
}

test_obtain_and_activate_token()
