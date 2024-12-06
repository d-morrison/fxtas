categorize_primary_race <- function(
    dataset,
    other_races = c(
      "Asian",
      "Native Hawaiian or Other Pacific Islander",
      "Australian Aborigine",
      "More Than One Race"
    )
){
  dataset |>
    dplyr::mutate(
      `Primary Race` =
        `Primary Race` |>
        forcats::fct_recode("Black" = "Black or African American") |>
        forcats::fct_other(drop = other_races) |>
        forcats::fct_relevel("White", "Black", "Other")
    )
}
