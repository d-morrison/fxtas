#' Get each participant's first visit in dataset
#'
#' @param dataset a [tibble::tbl_df] containing the following columns:
#' * `FXS ID`: participant ID number ([character()])
#' * `Visit Date`: date of clinic visit ([Date()])
#' * `Event Name`: role of clinic visit in the study design ([character()])
#'
#' @returns a [tibble::tbl_df]
#' @export
#'
#' @examples
#' test_data |> get_visit1()
get_visit1 = function(dataset)
{
  dataset |>
    arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
    mutate(.by = `FXS ID`, `# visits` = n()) |>
    slice_head(n = 1, by = `FXS ID`) |>
    dplyr::rename(
      `Age at visit` = `Age at visit`
    ) |>
    mutate(`# visits` = factor(`# visits`, levels = 1:max(`# visits`))) |>
    drop_levels() |>
    clean_gender()
}
