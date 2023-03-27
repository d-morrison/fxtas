define_cases_and_controls = function(dataset)
{
  dataset |>
    mutate(
      FX = `CGG (backfilled)` >= 55, # TRUE = cases
      `FX*` =
        if_else(FX, "CGG >= 55", "CGG < 55") |>
        factor() |>
        relevel(ref = "CGG < 55"),

      `FX**` = `FX*` |> forcats::fct_na_value_to_level()
    )
}
