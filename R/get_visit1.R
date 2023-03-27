get_visit1 = function(dataset)
{
  dataset |>
    arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
    group_by(`FXS ID`) |>
    slice_head(n = 1) |>
    ungroup() |>
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
