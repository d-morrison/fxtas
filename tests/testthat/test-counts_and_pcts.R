test_that("`counts_and_pcts()` produces consistent results", {

  x <- test_data$`Ataxia: severity*`

  actual <- x |> counts_and_pcts()
  expected <- c("406 (69.2%)", "93 (15.8%)", "44 (7.5%)", "33 (5.6%)", "11 (1.9%)") |>
    structure(class = c("glue", "character"))

  testthat::expect_equal(
    object = actual,
    expected = expected
  )

})
