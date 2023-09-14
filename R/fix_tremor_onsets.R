fix_tremor_onsets = function(dataset)
{
  dataset |>
    mutate(
      `Tremor: Age of onset` =

      # after discussion with Kyoungmi and Matt, 2023/08/01:
        if_else(
          (`Tremor: Age of onset` == 0) &
            (`Any tremor (excluding Head Tremor)` == "No Tremors Recorded"),
          NA_real_,
          `Tremor: Age of onset`
        )

    )
}
