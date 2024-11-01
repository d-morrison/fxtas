test_that("results are consistent", {
  test_data_v1 |>
    dplyr::filter(!is.na(CGG)) |>
    make_demographics_table() |>
    expect_no_error()
})

# need better tests here
