test_that("drop_levels() works", {
  data(gss_cat, package = "forcats")
  gss_cat2 = gss_cat |>
    head(30) |>
    drop_levels(except = "partyid")

  expect_equal(
    levels(gss_cat2$partyid),
    levels(gss_cat$partyid)
  )

  expect_equal(
    levels(gss_cat2$marital),
    unique(gss_cat2$marital) |> as.character()
  )
})
