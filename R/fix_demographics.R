fix_demographics <- function(dataset)
{
  dataset |>
    dplyr::mutate(

      `Birth Date` =
        (`Visit Date` - days(round(`Age at visit` * 365.25))) |>
        lubridate::date(), # causes problems for eg 	100399-100


    ) |>

    group_by(`FXS ID`) |>

    tidyr::fill(
      `Primary Race`,
      `Primary Ethnicity`,
      Gender,
      .direction = "downup") |>
    dplyr::mutate(
      `Recruited in study phase` = first(Study)
    ) |>
    ungroup()
}
