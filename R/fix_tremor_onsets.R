fix_tremor_onsets = function(dataset)
{
  dataset |>
    mutate(
      `Tremor: Age of onset` =

      # after discussion with Kyoungmi and Matt, 2023/08/01:
        if_else(
          (`Tremor: Age of onset` == 0) & (`Any tremor` == "No Tremors Recorded"),
          NA_real_,
          `Tremor: Age of onset`
        )

      # follwoing code subsumed by general onset fix?

      # `Tremor: Age of onset: missingness` =
      #   missingness_reasons(`Tremor: Age of onset`),
      #
      # `Tremor: Age of onset` =
      #   clean_numeric(`Tremor: Age of onset`),
      #
      # `Head Tremor: Age of onset: missingness` =
      #   `Head Tremor: Age of onset` |> missingness_reasons(),
      #
      # `Head Tremor: Age of onset` =
      #   `Head Tremor: Age of onset` |>
      #   factor(levels =
      #            `Head Tremor: Age of onset` |>
      #            unique() |>
      #            sort()) |>
      #   relabel_factor_missing_codes(),

    )
}
