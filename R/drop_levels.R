drop_levels = function(x, except)
{
  x |>
  mutate(
    across(
      .cols = where(is.factor) & !except,
      .fns = forcats::fct_drop)
    # unlike droplevels(), fct_drop() preserves attributes
  )
}
