test_that(
  "`categorize_MOCA()` categorizes all values.",
  {
    expect_equal(
      sum(gp34$`MOCA Total score*` %in% "uncategorized"),
      0)
  }
)
