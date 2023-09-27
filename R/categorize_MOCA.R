add_categorized_MOCA = function(dataset)
{
  dataset |> mutate(
    `MOCA Total score*` =
      `MOCA Total score` |>
      categorize_MOCA()
  )
}

categorize_MOCA = function(moca_data)
{
  case_when(
      moca_data <= 23 ~ "pathological",
      moca_data |> between(24,26) ~ "transitional",
      moca_data >= 27 ~ "healthy",
      is.na(moca_data) ~ NA_character_,
      .default = "uncategorized",
      .ptype =
        factor(
          levels = c(
            "healthy",
            "transitional",
            "pathological",
            "uncategorized"))
    ) |>
    droplevels()
}
