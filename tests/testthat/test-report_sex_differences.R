test_that("`report_sex_differences()` produces stable results", {

  library(dplyr)
  full_data = test_data_v1
  n_missing_CGG = full_data$CGG |> is.na() |> sum()
  n_above_200 = sum(full_data$CGG >= 200, na.rm = TRUE)
  v1_usable = full_data |> filter(CGG < 200) |>
    mutate(`FX3*` = `FX3*` |> forcats::fct_drop())

  biomarker_groups = compile_biomarker_groups_table(dataset = v1_usable)

  biomarker_varnames =
    biomarker_groups |>
    pull("biomarker")

  biomarker_levels =
    v1_usable |>
    get_levels(biomarker_varnames)

  biomarker_events_table =
    construct_biomarker_events_table(
      biomarker_levels,
      biomarker_groups = biomarker_groups)

  biomarkers_table =
    v1_usable |>
    make_biomarkers_table(
      biomarker_varnames = biomarker_varnames,
      biomarker_events_table = biomarker_events_table
    )
  report = report_sex_differences(biomarkers_table, cutoff = .2)
  expect_snapshot(report)

})
