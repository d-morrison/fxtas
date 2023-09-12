replace_missing_codes_with_No = function(x)
{
  x |>
    forcats::fct_recode(
      "No"   = "99",
      "No"   = "777",
      "No"   = "888",
      "No"   = "999",
      "No"   = "Asked by clinician, but no answer from subject (99)",
      "No"   = "Question not asked at time of data entry; check records (777)",
      "No"   = "NA (888)",
      "No"   = "No Response (999)",
      "None" = "Missing/Refused (999)"
    )
}
