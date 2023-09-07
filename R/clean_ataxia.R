clean_ataxia = function(data)
{
  data |>
    mutate(

      # `Ataxia: Age of onset missingness` =
      #   missingness_reasons(`Ataxia: Age of onset`),
      # `Ataxia: Age of onset` =
      #   clean_numeric(`Ataxia: Age of onset`),

      `Ataxia severity: missingness` =
        missingness_reasons(`Ataxia: severity`),

      # setting missing codes as 0s:
      `Ataxia: severity` =
        dplyr::if_else(
          condition = `Ataxia: severity` %in% c(888,999),
          true = "0",
          false = `Ataxia: severity`
        ),

      `Ataxia: severity` =
        `Ataxia: severity` |>
        clean_numeric(),

      `Ataxia` = if_else(
        `Ataxia: severity` %in% 0 & is.na(Ataxia),
        "No",
        `Ataxia`
      ) |> factor(levels = c("No", "Yes")),

      `Ataxia: severity` = if_else(
        Ataxia %in% "No" & is.na(`Ataxia: severity`),
        0,
        `Ataxia: severity`
      ),

      `Ataxia: severity*` =
        `Ataxia: severity` |>
        numeric_as_factor()

    )
}
