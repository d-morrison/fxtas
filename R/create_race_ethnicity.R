### create race/ethnicity variable ###
create_race_ethnicity <- function(dataset){
  # dataset |>
  #   mutate(
  #     tmp.race = forcats::fct_recode(
  #       `Primary Race`,
  #       # incorporate Asian into Other
  #       Other = "Asian"
  #     ),
  #     tmp.ethnicity
  #   ) |>
  #   tidyr::unite(
  #     col = `Primary Race/Ethnicity`,
  #     tmp.ethnicity, tmp.race,
  #     sep = ", ",
  #     remove = TRUE,
  #     na.rm = TRUE
  #   )
  dataset |>
    mutate(
      `Primary Race` = forcats::fct_recode(
        `Primary Race`,
        # incorporate Asian into Other
        Other = "Asian"
      ),
      `Primary Race/Ethnicity` = case_when(
        `Primary Ethnicity` == "Hispanic or Latino" ~ "Hispanic",
        `Primary Race` == "Caucasian" ~ "Caucasian",
        `Primary Race` == "Black or African American" ~ "Black",
        (is.na(`Primary Race`) & is.na(`Primary Ethnicity`)) ~ NA_character_,
        .default = "Other"
      )
    )
}
