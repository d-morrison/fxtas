test_that("`test_biomarkers_table()` produces consistent results", {


  df = sim_data

  biomarker_group_list = list(
    "group 1" = c("Biomarker 1", "Biomarker 2"),
    "group 2" = c("Biomarker 3", "Biomarker 4"),
    "group 3" = "Biomarker 5"
  )

  biomarker_groups =
    compile_biomarker_groups_table(
      dataset = df,
      biomarker_group_list = biomarker_group_list)

  SuStaInLabels = biomarkers = biomarker_varnames =
    biomarker_groups |>
    dplyr::pull("biomarker")

  biomarker_levels =
    df |>
    get_levels(biomarker_varnames)

  biomarker_events_table =
    construct_biomarker_events_table(
      biomarker_levels,
      biomarker_groups = biomarker_groups)

  biomarkers_table =
    df |>
    make_biomarkers_table(
      biomarker_varnames = biomarker_varnames,
      biomarker_events_table = biomarker_events_table,
      stratifying_var_names = "Sex"
    )
  biomarkers_table |>
  ssdtools:::expect_snapshot_data(name = "biomarkers_table")
})
