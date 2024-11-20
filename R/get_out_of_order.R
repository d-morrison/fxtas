get_out_of_order <- function(dataset)
{
  dataset |>
    select(`FXS ID`, `Visit Date`, `Event Name`) |>
    group_by(`FXS ID`) |>
    filter(is.unsorted(`Event Name`)) |>
    # filter(any(`decreased age`, na.rm = TRUE)) |>
    # ungroup() |>
    group_split()
}
