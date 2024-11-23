get_decreased_age <- function(dataset)
{
  dataset |>
    arrange(`FXS ID`, `Event Name`) |> # not sure about this one; added later to clarify difference from below
    group_by(`FXS ID`) |>
    mutate(
      `diff age` = c(NA, diff(`Age at visit`)),
      `decreased age` = `diff age` < 0) |>
    filter(any(`decreased age`, na.rm = TRUE)) |>
    ungroup() |>
    select(`FXS ID`, `Event Name`, `Visit Date`, `Age at visit`, `diff age`, `decreased age`)
}

get_decreased_age2 <- function(dataset)
{
  dataset |>
    arrange(`FXS ID`, `Visit Date`) |>
    group_by(`FXS ID`) |>
    mutate(
      `diff age` = c(NA, diff(`Age at visit`)),
      `decreased age` = `diff age` < 0) |>
    filter(any(`decreased age`, na.rm = TRUE)) |>
    ungroup() |>
    select(`FXS ID`, `Event Name`, `Visit Date`, `Age at visit`, `diff age`, `decreased age`)
}
