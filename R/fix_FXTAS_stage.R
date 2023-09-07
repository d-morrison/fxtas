fix_FXTAS_stage = function(dataset)
{

  output =
    dataset |>
    mutate(
      `FXTAS Stage (0-5)*` =
        `FXTAS Stage (0-5)` |>
        case_match(
          2.5 ~ 2,
          3.5 ~ 4,
          4.5 ~ 5,
          .default = `FXTAS Stage (0-5)`) |>
        na_if(999) |>
        numeric_as_factor(),

      `FXTAS Stage (0-5)` = `FXTAS Stage (0-5)` |> clean_numeric(),

      # across(c(`FXTAS Stage (0-5)`), numeric_as_factor)
    )

}
