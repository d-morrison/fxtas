fix_factors = function(dataset)
{
  dataset |>
    mutate(
      across(
        where(is.factor) &
          !contains(": missingness reasons") &
          !contains("FX**"),

        list(
          tmp = replace_missing_codes_with_NAs,
          `missingness reasons` = missingness_reasons.factor),
        .names = "{.col}{if_else(.fn != 'tmp', paste0(': ', .fn), '')}"),

    )
}
