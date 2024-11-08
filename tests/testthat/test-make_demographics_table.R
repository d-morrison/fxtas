test_that("results are consistent", {
  ft = test_data_v1 |>
    dplyr::filter(!is.na(CGG)) |>
    make_demographics_table()

  html_file <- tempfile(fileext = ".html")
  flextable::save_as_html(ft, path = html_file)
  doconv::expect_snapshot_html(
    x = html_file,
    name = "demographics_table",
    engine = "testthat"
  )
})

# need better tests here
