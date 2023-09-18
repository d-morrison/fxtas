categorize_primary_race <- function(
    dataset,
    other_races = c(
      "Native Hawaiian or Other Pacific Islander",
      "Australian Aborigine",
      "More Than One Race"
    )
){
  dataset |>
    mutate(
      `Primary Race` =
        `Primary Race` |>
        forcats::fct_recode("White" = "Caucasian") |>
        forcats::fct_other(drop = other_races) |>
        forcats::fct_relevel("White", "Black or African American", "Asian", "Other")
    )
}
