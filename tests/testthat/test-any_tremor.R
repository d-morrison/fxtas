test_that(
  "`Any tremor (excluding head)` is consistent with the individual tremor variables",
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
        `Any tremor (excluding head)` %in%
          "No tremors recorded",
        if_all(all_of(tremor_types), is.na)
      )

    expect_equal(object = nrow(inconsistent), expected = 0)
  })
