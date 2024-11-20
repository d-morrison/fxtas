drop_levels <- function(x, except = NULL)
{
  x |>
  mutate(
    across(
      .cols = where(is.factor) & !all_of(except),
      .fns = forcats::fct_drop)
    # unlike droplevels(), fct_drop() preserves attributes
  )
}
