fix_tremors = function(dataset)
{
  dataset |>
    mutate(

      `Tremor: Age of onset: missingness` =
        missingness_reasons(`Tremor: Age of onset`),

      `Tremor: Age of onset` =
        clean_numeric(`Tremor: Age of onset`),

      `Head Tremor: Age of onset: missingness` =
        `Head Tremor: Age of onset` |> missingness_reasons(),

      `Head Tremor: Age of onset` =
        `Head Tremor: Age of onset` |>
        factor(levels =
                 `Head Tremor: Age of onset` |>
                 unique() |>
                 sort()) |>
        relabel_factor_missing_codes(),

    )
}
