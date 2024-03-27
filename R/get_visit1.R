#' Get each participant's first visit in dataset
#'
#' @param dataset a [tibble::tbl] containing the following columns:
#' * `FXS ID`: participant ID number ([character()])
#' * `Visit Date`: date of clinic visit ([Date()])
#' * `Event Name`: role of clinic visit in the study design ([character()])
#'
#' @returns a [tibble::tbl]
#' @export
#'
#' @examples
#' gp34 |> get_visit1()
get_visit1 = function(dataset)
{
  dataset |>
    arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
    mutate(.by = `FXS ID`, `# visits` = n()) |>
    slice_head(n = 1, by = `FXS ID`) |>
    dplyr::rename(
      `Age at first visit` = `Age at visit`
    ) |>
    mutate(`# visits` = factor(`# visits`, levels = 1:max(`# visits`))) |>
    droplevels()
}
