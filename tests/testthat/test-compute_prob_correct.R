test_that("compute_prob_correct() produces consistent results", {
  full_data <- test_data_v1

  v1_usable <- full_data |> dplyr::filter(CGG < 200)

  biomarker_groups <- compile_biomarker_groups_table()

  biomarker_varnames <-
    biomarker_groups |>
    pull("biomarker")

  biomarker_levels <-
    v1_usable |>
    dplyr::select(all_of(biomarker_varnames)) |>
    lapply(F = levels)

  control_data <-
    v1_usable |>
    dplyr::filter(`FX*` == "CGG <55") |>
    select(all_of(biomarker_varnames))

  control_data |>
    compute_prob_correct(max_prob = .95, biomarker_levels = biomarker_levels) |>
    attr("data") |>
    ssdtools:::expect_snapshot_data(name = "prob-correct")
})
