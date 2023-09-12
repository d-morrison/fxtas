categorize_MMSE = function(
    dataset,
    levels = c(
      "normal (26-30)",
      "mild impairment (20-25)",
      "moderate impairment (10-19)",
      "severe imparitment (0-9)"
    ))
{
  dataset |>
    mutate(
      `MMSE Total Score*` =
        `MMSE Total Score` |>
        case_match(
          26:30 ~ levels[1],
          20:25   ~ levels[2],
          10:19   ~ levels[3],
          0:9     ~ levels[4]
        ) |>
        factor(levels = levels)
    )
}
