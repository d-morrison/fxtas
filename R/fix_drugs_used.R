fix_drugs_used <- function(dataset)
{
  dataset |>
    mutate(
      `Drugs used` =
        `Drugs used` |>
        factor(levels = sort(unique(.x)))
    )
}
