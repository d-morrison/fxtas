categorize_BDS <- function(dataset)
{
  dataset |>
    dplyr::mutate(
      `BDS-2 Total Score*` =
        if_else(
          `BDS-2 Total Score` < 20,
          "< 20",
          "\u2265 20"
        ) |>
        factor() |>
        relevel(ref = "\u2265 20")
    )
}
