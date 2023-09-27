test_that(
  "`Any tremor (excluding Head Tremor)` is consistent with the individual tremor variables",
  {
    library(dplyr)
    tremor_types = c(
      "Intention tremor",
      "Resting tremor",
      "Postural tremor",
      "Intermittent tremor"
    )

    inconsistent =
      gp34 |>
      dplyr::filter(
        `Any tremor (excluding Head Tremor)` %in%
          "No tremors recorded",
        if_all(all_of(tremor_types), is.na)
      ) |>
      dplyr::select(
        all_of(tremor_types),
        `Any tremor (excluding Head Tremor)`
      )

    expect_equal(object = nrow(inconsistent), expected = 0)
  })
