clean_ataxia = function(data)
{
  data |>
    mutate(

      # `Ataxia: Age of onset missingness` =
      #   missingness_reasons(`Ataxia: Age of onset`),
      # `Ataxia: Age of onset` =
      #   clean_numeric(`Ataxia: Age of onset`),

      `Ataxia severity: missingness` = missingness_reasons(`Ataxia: severity`),

      `Ataxia: severity*` = `Ataxia: severity` |> numeric_as_factor(),

      `Ataxia: severity` = `Ataxia: severity` |> clean_numeric(),

      `Ataxia` = if_else(
        `Ataxia: severity` %in% 0 & is.na(Ataxia),
        "No",
        `Ataxia`
      ),

      `Ataxia: severity` = if_else(
        Ataxia %in% "No" & is.na(`Ataxia: severity`),
        0,
        `Ataxia: severity`
      )

    )
}
