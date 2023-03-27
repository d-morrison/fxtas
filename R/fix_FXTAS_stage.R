fix_FXTAS_stage = function(dataset)
{

  dataset |>
  mutate(
    `FXTAS Stage (0-5)*` =
      `FXTAS Stage (0-5)` |>
      na_if(999) |>
      numeric_as_factor(),

    `FXTAS Stage (0-5)` = `FXTAS Stage (0-5)` |> clean_numeric(),

    # across(c(`FXTAS Stage (0-5)`), numeric_as_factor)
  )

}
