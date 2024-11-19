test_that("`extract_subtype_and_stage_table()` produces consistent results", {

  output_folder <-
    here::here() |>
    fs::path("output/SuStaIn-simulated-data/")

  picklename = "sample_data_subtype2.pickle"
  results00 =
    output_folder |>
    fs::path("pickle_files", picklename) |>
    py_load_object() |>
    force()

  table1 = results00 |> extract_subtype_and_stage_table()

  ssdtools:::expect_snapshot_data(table1, name = "SuStaIn_ML_table")

})
