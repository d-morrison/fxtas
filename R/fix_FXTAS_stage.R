fix_FXTAS_stage <- function(dataset)
{

  output =
    dataset |>
    dplyr::mutate(
      `FXTAS Stage` =
        `FXTAS Stage (0-5)` |>
        case_match(
          0.5 ~ 0,
          1.5 ~ 1,
          2.5 ~ 2,
          3.5 ~ 4,
          4.5 ~ 5,
          .default = `FXTAS Stage (0-5)`) |>
        na_if(999) |>
        factor(),

      # created both to avoid missing variable in other scripts
      `FXTAS Stage (0-5): missingness reasons` =
        missingness_reasons.numeric(`FXTAS Stage (0-5)`),

      `FXTAS Stage (0-5)` = `FXTAS Stage (0-5)` |> clean_numeric()

    )

}
