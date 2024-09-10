test_that("make_demographics_table()` produces consistent results", {
  trax_gp34_all |> make_demographics_table() |>
    expect_snapshot()
})
