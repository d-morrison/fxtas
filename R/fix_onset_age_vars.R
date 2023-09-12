fix_onset_age_vars = function(dataset)
{
  dataset |>
    mutate(
      across(
        .cols = ends_with("Age of onset"),
        .fns = list(
          `missingness reasons` =
            ~missingness_reasons.numeric(
              .x,
              extra_codes = 99),
          tmp = # note: gets renamed on line 21 below
            ~ .x |>
            age_range_medians() |>
            clean_numeric(extra_codes = c(
              # 555, # lifelong - now handled as min(10, min(numeric_vals))
              99))
        ),
        .names = "{.col}{if_else(.fn != 'tmp', paste0(': ', .fn), '')}"
      )
    )
}
