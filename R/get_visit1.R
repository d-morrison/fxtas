get_visit1 = function(dataset)
{
  dataset |>
    arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
    slice_head(n = 1, by = `FXS ID`) |>
    rename(
      `Age at first visit` = `Age at visit`
    ) |>
    left_join(
      gp34 |> count(`FXS ID`, name = "# visits"),
      by = "FXS ID"
    ) |>
    mutate(`# visits` = factor(`# visits`, levels = 1:6)) |>
    droplevels()
}
