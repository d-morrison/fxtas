clean_SCID = function(
    dataset,
    scid_vars = c(
      "Bipolar I Disorder (MD01), Lifetime",
      "Bipolar I Disorder (MD01), Current",
      "Bipolar II Disorder (MD02), Lifetime",
      "Bipolar II Disorder (MD02), Current",
      "Other Bipolar Disorder (MD03), Current",
      "Other Bipolar Disorder (MD03), Lifetime",
      "Major Depressive Disorder (MD04), Lifetime",
      "Major Depressive Disorder (MD04), Current",
      "Mood Disorder Due to a GMC (MD07), Lifetime",
      "Mood Disorder Due to a GMC (MD07), Current",
      "Substance-Induced Mood Dis. (MD08), Lifetime",
      "Substance-Induced Mood Dis. (MD08), Current",
      "Primary Psychotic Symptoms (PS01), Lifetime",
      "Primary Psychotic Symptoms (PS01), Current"
    ))
{
  dataset |>
    mutate(
      across(
        .cols = all_of(scid_vars),
        .fns =
          ~ if_else(
            condition =
              `Was SCID completed?` %in% "No" &
              . %in% "Missing (empty in RedCap)",
            true =
              factor(
                "Missing (SCID not completed)",
                levels = c(levels(.), "Missing (SCID not completed)")),
            false = .)
      )
    ) |>
    create_scid_domains()
}
