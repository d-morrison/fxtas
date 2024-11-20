test_that(
  "`Tremor: Age of onset: missingness reasons` matches `Tremor: Age of onset`",

  {

    skip_if_not(exists("gp34"))

    inconsistent =
      gp34 |>
      filter(
        is.na(`Tremor: Age of onset`),
        `Tremor: Age of onset: missingness reasons` == "[Valid data recorded]") |>
      select(
        `Tremor: Age of onset`,
        `Tremor: Age of onset: missingness reasons`)

    expect_equal(object = nrow(inconsistent), expected = 0)


  })
