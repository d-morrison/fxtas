categorize_BDS = function(dataset)
{
  dataset |>
    mutate(
      `BDS-2 Total Score*` =
        if_else(
          `BDS-2 Total Score` < 20,
          "< 20",
          ">= 20"
        ) |>
        factor() |>
        relevel(ref = ">= 20")
    )
}
