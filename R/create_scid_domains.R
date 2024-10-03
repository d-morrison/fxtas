#' @title Create SCID domain variables
#'
#' @param dataset a [tibble::tbl_df] containing all of `scid_vars` as columns
#' @param scid_vars a [character()] vector
#'
#' @returns a [tibble::tbl_df]
#' @export
#'
create_scid_domains <- function(
  dataset,
  scid_vars = c(
    "Bipolar I Disorder (MD01), Lifetime",
    "Bipolar I Disorder (MD01), Current",
    "Bipolar II Disorder (MD02), Lifetime",
    "Bipolar II Disorder (MD02), Current",
    "Other Bipolar Disorder (MD03), Current",
    "Other Bipolar Disorder (MD03), Lifetime",
    "Major Depressive Disorder (MD04), Current",
    "Major Depressive Disorder (MD04), Lifetime",
    "Mood Disorder Due to GMC (MD07), Current",
    "Mood Disorder Due to GMC (MD07), Lifetime",
    "Substance-Induced Mood Dis. (MD08), Current",
    "Substance-Induced Mood Dis. (MD08), Lifetime",
    "Primary Psychotic Symptoms (PS01), Current",
    "Primary Psychotic Symptoms (PS01), Lifetime",
    "Dysthymic Disorder (MD05), Lifetime",
    "Depressive Disorder NOS (MD06), Lifetime",
    "Depressive Disorder NOS (MD06) Current",
    "Alcohol (SUD17), Lifetime",
    "Alcohol (SUD17) Current",
    "Sedative-Hypnotic-Anxiolytic (SUD18), Lifetime",
    "Sedative-Hypnotic-Anxiolytic (SUD18), Current",
    "Cannabis (SUD19), Lifetime",
    "Cannabis (SUD19),Current",
    "Stimulants (SUD20), Lifetime",
    "Stimulants (SUD20) Current",
    "Opioid (SUD21), Lifetime",
    "Cocaine (SUD22), Lifetime",
    "Opioid (SUD21), Current",
    "Hallucinogenics/ PCP (SUD23), Lifetime",
    "Cocaine (SUD22) Current",
    "Hallucinogenics/ PCP (SUD23), Current",
    "Poly Drug (SUD24), Lifetime",
    "Poly Drug (SUD24), Current",
    "Other (SUD25), Lifetime",
    "Other (SUD25), Current",
    "Panic Disorder (ANX26), Lifetime",
    "Panic Disorder (ANX26), Current",
    "Agoraphobia without Panic (ANX27), Lifetime",
    "Agoraphobia without Panic (ANX27), Current",
    "Social Phobia (ANX28), Lifetime",
    "Social Phobia (ANX28), Current",
    "Specific Phobia (ANX29), Lifetime",
    "Specific Phobia (ANX29), Current",
    "Obsessive Compulsive (ANX30), Lifetime",
    "Obsessive Compulsive (ANX30), Current",
    "Posttraumatic Stress (ANX31), Lifetime",
    "Posttraumatic Stress (ANX31), Current",
    "Generalized Anxiety (ANX32), Current Only",
    "Anxiety Due to GMC (ANX33), Lifetime",
    "Anxiety Due to GMC (ANX33), Current",
    "Substance-Induced Anxiety (ANX34), Lifetime",
    "Substance-Induced Anxiety (ANX34), Current",
    "Anxiety Disorder NOS (ANX35), Lifetime",
    "Anxiety Disorder NOS (ANX35), Current",
    "Somatization Disorder (SOM36)",
    "Pain Disorder (SOM37)",
    "Undifferentiated Somatoform (SOM38)",
    "Body Dysmorphic (SOM40)",
    "Hypochondriasis (SOM39)"
  )
){
  # split scid_vars into current/lifetime
  # lifetime + Generalized Anxiety
  # Note: Generalized Anxiety goes with `lifetime` vars because:
  # 1) There is no lifetime version,
  # 2) it has the same Absent/Sub-Threshold/Threshold levels as the lifetime variables
  lifetime_vars <- c(scid_vars[!grepl("Current", scid_vars)],
                     "Generalized Anxiety (ANX32), Current Only")
  # current - Generalized Anxiety
  current_vars <- setdiff(scid_vars, lifetime_vars)
  # split scid_vars into the domains #
  # mood disorders
  scid_md_vars <- scid_vars[grepl("\\(MD", scid_vars)]
  # substance use disorders
  scid_sud_vars <- scid_vars[grepl("\\(SUD", scid_vars)]
  # anxiety
  scid_anx_vars <- scid_vars[grepl("\\(ANX", scid_vars)]
  # somatization
  scid_somatic_vars <- scid_vars[grepl("\\(SOM", scid_vars)]
  # psychotic
  scid_psych_vars <- scid_vars[grepl("\\(PS", scid_vars)]

  # remove 'current' variables from each domain
  scid_md_vars_lif <- scid_md_vars[scid_md_vars %in% lifetime_vars]
  scid_sud_vars_lif <- scid_sud_vars[scid_sud_vars %in% lifetime_vars]
  scid_anx_vars_lif <- scid_anx_vars[scid_anx_vars %in% lifetime_vars]
  scid_somatic_vars_lif <- scid_somatic_vars[scid_somatic_vars %in% lifetime_vars]
  scid_psych_vars_lif <- scid_psych_vars[scid_psych_vars %in% lifetime_vars]

  dataset |>
    # convert scid_vars to ordered factors
    mutate(
      across(
        .cols = all_of(lifetime_vars),
        ~ factor(.x, levels = c("Absent", "Sub-Threshold", "Threshold"),
                 ordered = TRUE)
      ),
      across(
        .cols = all_of(current_vars),
        ~ factor(.x, levels = c("Absent", "Present"), ordered = TRUE)
      )
    ) |>
    # create domain variables using max level
    mutate(
      # notes: could use `do.call()`, `invoke()`, `rowwise() & max()`;
      # no clearly most-idiomatic approach as of 2024-03-22
      # some discussion here: https://r4ds.hadley.nz/numbers.html#numeric-transformations
      `SCID: Mood Disorders` = pmax(!!!rlang::syms(scid_md_vars_lif), na.rm = TRUE),
      `SCID: Substance Use Disorders` = pmax(!!!rlang::syms(scid_sud_vars_lif), na.rm = TRUE),
      `SCID: Anxiety Disorders` = pmax(!!!rlang::syms(scid_anx_vars_lif), na.rm = TRUE),
      `SCID: Somatization Disorders` = pmax(!!!rlang::syms(scid_somatic_vars_lif), na.rm = TRUE),
      `SCID: Psychotic Symptoms` = pmax(!!!rlang::syms(scid_psych_vars_lif), na.rm = TRUE)
    )
}
