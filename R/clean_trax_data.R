clean_trax_data = function(dataset)
{
  dataset |>
    # fix date before arranging
    fix_date() |>

    arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
    remove_unneeded_records() |>
    dplyr::relocate(`Visit Date`, .after = `Event Name`) |>
    dplyr::relocate(`FXS ID`, .before = `Event Name`) |>
    # clean_head_tremor_onset() |>

    create_any_tremor() |>
    fix_tremor_onsets() |>

    fix_onset_age_vars() |>

    fix_iq() |>

    clean_kinesia() |>
    # includes BDS, MMSE
    make_vars_numeric(regex = "score", ignore.case = TRUE) |>
    make_vars_numeric(regex = "Full Scale IQ", ignore.case = TRUE) |>

    make_vars_numeric(regex = "Purdue pegboard") |>
    make_vars_numeric(regex = "SCL90") |>
    categorize_SCL90() |>


    create_any_cancer() |>

    create_any_autoimmune() |>


    categorize_BDS() |>

    # make_vars_numeric(regex = "BDS-2 Total Score") |>
    # make_vars_numeric(regex = "MMSE Total Score") |>

    # `Drugs used` is unstructured text, with typos; unusable
    # fix_drugs_used() |>

    # categorize_MMSE() |>

    # fix_ApoE() |>

    fix_CGG() |>


    # dplyr::relocate(contains("CGG"), .after = contains("ApoE")) |>

    fix_FXTAS_stage() |>

    fix_demographics() |>

    clean_MRI_vars() |>

    clean_cantab() |>

    clean_SCID() |>

    fix_drinks_per_day() |>

    # create SCID and MRI domains
    create_scid_domains() |>
    create_mri_domains() |>

    # cases and controls
    define_cases_and_controls() |>

    # Ataxia
    clean_trax_ataxia() |>

    fix_factors() |>

    # clean/recode race and ethnicity
    categorize_primary_race() |>
    # clean_ethnicity() |> # fixed upstream during data import
    create_race_ethnicity() |>

    droplevels(
      except = c("Cerebral Atrophy", "Cerebellar Atrophy",
                 "Cerebral WM Hyperintensity", "Cerebellar WM Hyperintensity",
                 "MCP-WM Hyperintensity", "Pons-WM Hyperintensity",
                 "Sub-Insular WM Hyperintensity", "Periventricular WM Hyperintensity",
                 "Splenium (CC)-WM Hyperintensity", "Genu (CC)-WM Hyperintensity",
                 "Corpus Callosum-Thickness",
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
                 "Dysthymic Disorder (MD05)",
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
                 "Opiod (SUD21), Lifetime",
                 "Cocaine (SUD22), Lifetime",
                 "Opiod (SUD21), Current",
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
                 "Hypochondriasis (SOM39)",
                 # scid domains
                 "SCID: Mood Disorders", "SCID: Anxiety",
                 "SCID: Substance Use",
                 "SCID: Somatization",
                 "SCID: Psychotic",
                 # mri domains
                 "MRI: Cerebral", "MRI: Cerebellar")
    ) |>
    clean_gender()
}
