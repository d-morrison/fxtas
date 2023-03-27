fix_drugs_used = function(dataset)
{
  dataset |>
    mutate(
      across(
        c(`Drugs used`),
        ~ .x |>
          factor(levels = sort(unique(.x))) |>
          relabel_factor_missing_codes()
      )
    )
}
