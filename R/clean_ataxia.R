clean_ataxia = function(data)
{
  data |>
    mutate(

      `Ataxia severity: missingness reasons` =
        missingness_reasons.numeric(`Ataxia: severity`),

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

      `Ataxia` =
        if_else(
          condition =
            (`Ataxia: severity` %in% 0) & is.na(Ataxia),
          true = "No",
          false = `Ataxia`
        ) |>
        factor(levels = c("No", "Yes")),

      `Ataxia: severity` =
        if_else(
        condition =
          (Ataxia %in% "No") & is.na(`Ataxia: severity`),
        true = 0,
        false = `Ataxia: severity`
      ),

      `Ataxia: severity*` =
        `Ataxia: severity` |>
        factor()

    )
}
