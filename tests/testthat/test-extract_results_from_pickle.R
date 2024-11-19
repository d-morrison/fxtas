test_that("`extract_results_from_pickle()` produces stable results", {

  results = here::here() |>
    fs::path("output/SuStaIn-simulated-data/") |>
    extract_results_from_pickle(output_folder = _)

  results$samples_sequence = NULL
  results$samples_f = NULL
  results |>
    expect_snapshot_value(style = "serialize")
})
