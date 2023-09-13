x = factor(
  c("setosa", "versicolor", "virginica"),
  levels = c("setosa", "virginica", "versicolor"))

test_that("replace_missing_codes() works with default", {

  actual = x |> replace_missing_codes(missing_codes = "virginica")
  expected = factor(
    c("setosa", "versicolor", "setosa"),
    levels = c("setosa", "versicolor"))
  expect_equal(object = actual, expected = expected)
})

test_that("replace_missing_codes() works with custom new label", {
  actual = x |> replace_missing_codes(
    missing_codes = "virginica",
    replacement = "test_level")
  expected = factor(
    c("setosa", "versicolor", "test_level"),
    levels = c("setosa", "test_level", "versicolor"))
  expect_equal(object = actual, expected = expected)
})

test_that("replace_missing_codes() works with NA", {
  actual = x |> replace_missing_codes(
    missing_codes = "virginica",
    replacement = NA)
  expected = factor(
    c("setosa", "versicolor", NA),
    levels = c("setosa", "versicolor"))
  expect_equal(object = actual, expected = expected)
})

