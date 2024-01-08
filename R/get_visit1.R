get_visit1 = function(dataset)
{
  dataset |>
    arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
    mutate(.by = `FXS ID`, `# visits` = n()) |>
    slice_head(n = 1, by = `FXS ID`) |>
    rename(
      `Age at first visit` = `Age at visit`
    ) |>
    mutate(`# visits` = factor(`# visits`, levels = 1:max(`# visits`))) |>
    droplevels()
}
