test_that("`extract_results_from_pickle()` produces stable results", {

  output_path =
    fs::path_package("extdata/sim_data", package = "fxtas")

  results =
    extract_results_from_pickle(output_folder = output_path,
                                use_rds = FALSE)

  results$samples_sequence = NULL
  results$samples_f = NULL
  results |>
    expect_snapshot_value(style = "serialize")
})
