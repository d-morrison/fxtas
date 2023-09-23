test_that(
  "`Any Cancer` is consistent with the individual cancer variables",
  {
    cancer_types = c(
      "Thyroid Cancer",
      "Skin Cancer",
      "Melanoma",
      "Prostate Cancer",
      "Other Cancer"
    )

    inconsistent =
      gp34 |>
      filter(
        `Any Cancer` %in% "No cancers recorded",
        if_all(all_of(cancer_types), is.na)
      )

    expect_equal(object = nrow(inconsistent), expected = 0)
  })
