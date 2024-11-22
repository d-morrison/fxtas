test_that("`extract_subtype_and_stage_table()` produces consistent results", {

  output_path =
    fs::path_package("extdata/sim_data", package = "fxtas")

  picklename = "sample_data_subtype2.pickle"
  results00 =
    output_path |>
    fs::path("pickle_files", picklename) |>
    py_load_object() |>
    force()

  table1 = results00 |> extract_subtype_and_stage_table()

  ssdtools:::expect_snapshot_data(table1, name = "SuStaIn_ML_table")

})
