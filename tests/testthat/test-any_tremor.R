test_that(
  "`Any tremor (excluding Head Tremor)` is consistent with the individual tremor variables",
  {
    tremor_types = c(
      "Intention tremor",
      "Resting tremor",
      "Postural tremor",
      "Intermittent tremor"
    )

    inconsistent =
      gp34 |>
      filter(
        `Any tremor (excluding Head Tremor)` %in% "No tremors recorded",
        if_all(all_of(tremor_types), is.na)
      )

    expect_equal(object = nrow(inconsistent), expected = 0)
  })
