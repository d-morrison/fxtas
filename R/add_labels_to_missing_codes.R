add_labels_to_missing_codes = function(x)
{
  x |>
    forcats::fct_recode(
      "Asked by clinician, but no answer from subject (99)" = "99" ,
      "Question not asked at time of data entry; check records (777)" = "777",
      "NA (888)" = "888",
      "No Response (999)" = "999"
    ) |>
    # tidyr::replace_na("Missing (empty in RedCap)") |> # doesn't work with factors
    forcats::fct_na_value_to_level(level = "Missing (empty in RedCap)") |>
    forcats::fct_relevel(
      "Asked by clinician, but no answer from subject (99)",
      "Question not asked at time of data entry; check records (777)",
      "NA (888)",
      "No Response (999)",
      "Missing/Refused (999)",
      "Missing (empty in RedCap)",
      after = Inf) |>
    # previous two functions throw warnings if some codes aren't present:
    suppressWarnings() |>
    droplevels()


}
