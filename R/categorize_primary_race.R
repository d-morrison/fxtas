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
      `Primary Race` = case_when(
        `Primary Race` == "White" ~ "Caucasian",
        `Primary Race` %in% other_races ~ "Other",
        TRUE ~ `Primary Race`
      )
    )
}
