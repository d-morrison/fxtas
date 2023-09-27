clean_data = function(dataset)
{
  dataset |>
    arrange(`FXS ID`, `Visit Date`, `Event Name`) |>
    remove_unneeded_records() |>
    relocate(`Visit Date`, .after = `Event Name`) |>
    clean_head_tremor_onset() |>


    clean_kinesia() |>
    # includes BDS, MMSE
    make_vars_numeric(regex = "score", ignore.case = TRUE) |>
    add_categorized_MOCA() |>


    make_vars_numeric(regex = "Purdue pegboard") |>
    make_vars_numeric(regex = "SCL90") |>
    categorize_SCL90() |>


    categorize_BDS() |>

    # make_vars_numeric(regex = "BDS-2 Total Score") |>
    # make_vars_numeric(regex = "MMSE Total Score") |>

    # `Drugs used` is unstructured text, with typos; unusable
    # fix_drugs_used() |>

    categorize_MMSE() |>

    fix_ApoE() |>

    fix_CGG() |>

    relocate(contains("CGG"), .after = contains("ApoE")) |>

    fix_FXTAS_stage() |>

    fix_demographics() |>

    clean_MRI_vars() |>

    clean_cantab() |>

    clean_SCID() |>

    fix_drinks_per_day() |>

    # cases and controls
    define_cases_and_controls() |>

    # Ataxia
    clean_ataxia() |>

    # Fix factors: recode missing codes to NA
    fix_factors() |>

    categorize_primary_race() |>

    # handle tremor variables
    create_any_tremor() |>

    fix_tremor_onsets() |>

    fix_onset_age_vars() |>

    # create any cancer and any autoimmune
    create_any_cancer() |>
    create_any_autoimmune() |>


    fix_head_tremor() |>

    droplevels()
}
