fix_factors = function(dataset)
{
  dataset |>
    mutate(
      across(
        where(is.factor) &
          !contains(": missingness") &
          !contains("FX**"),

        relabel_factor_missing_codes),
      # across(
      #   where(is.factor),
      #   ~ . |> forcats::fct_na_value_to_level(level = "Missing (empty in RedCap)")
      #   )
    )
}
