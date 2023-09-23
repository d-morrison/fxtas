test_that(
  "`Any Autoimmune` is consistent with the individual autoimmune variables",
  {
    autoimmune_dz = c(
      "Lupus",
      "Rheumatoid arthritis",
      "Multiple Sclerosis: Workup",
      "ANA positive",
      "Sjogrens Syndrome",
      "Raynauds Syndrome",
      "Pulmonary Fibrosis"
    )

    inconsistent =
      gp34 |>
      filter(
        `Any Autoimmune` %in% "No autoimmune recorded",
        if_all(all_of(autoimmune_dz), is.na)
      )

    expect_equal(object = nrow(inconsistent), expected = 0)
  })
