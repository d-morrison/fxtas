clean_trax_data = function(dataset)
{
  dataset |>
    # fix date before arranging
    fix_date() |>

    arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
    remove_unneeded_records() |>
    relocate(`Visit Date`, .after = `Event Name`) |>
    relocate(`FXS ID`, .before = `Event Name`) |>
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


    # relocate(contains("CGG"), .after = contains("ApoE")) |>

    fix_FXTAS_stage() |>

    fix_demographics() |>

    clean_MRI_vars() |>

    clean_cantab() |>

    clean_SCID() |>

    fix_drinks_per_day() |>

    # cases and controls
    define_cases_and_controls() |>

    # Ataxia
    clean_trax_ataxia() |>

    fix_factors() |>

    categorize_primary_race() |>

    droplevels()
}
