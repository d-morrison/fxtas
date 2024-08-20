categorize_MMSE = function(
    dataset,
    levels = c(
      "Normal (26-30)",
      "Mild (20-25)",
      "Moderate (10-19)",
      "Severe (0-9)"
    ))
{
  dataset |>
    mutate(
      `MMSE total score*` =
        `MMSE total score` |>
        case_match(
          26:30 ~ levels[1],
          20:25   ~ levels[2],
          10:19   ~ levels[3],
          0:9     ~ levels[4]
        ) |>
        factor(levels = levels)
    )
}
