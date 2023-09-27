test_that(
  "`categorize_MOCA()` categorizes all values.",
  {
    sum(gp34$`MOCA Total score*` %in% "uncategorized") == 0
  }
)
