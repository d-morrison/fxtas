clean_head_tremor_onset <- function(dataset)
{
  dataset |>
    mutate(

      `Head Tremor: Age of onset` =
        `Head Tremor: Age of onset` |> dplyr::recode("68-67" = "67.5"),
      # "68-67" |> strsplit("-") |> sapply(F <- function(x) median(as.numeric(x)))
    )
}
