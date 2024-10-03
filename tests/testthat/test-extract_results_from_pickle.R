# test_that("`extract_results_from_pickle()` produces stable results", {
#   here::here() |>
#     fs::path("output/output.fixed_CV") |>
#     extract_results_from_pickle(output_folder = _) |>
#     expect_snapshot_value(style = "serialize")
# })
