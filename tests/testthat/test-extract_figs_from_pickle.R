test_that("`extract_figs_from_pickle()` produces stable results", {
  here::here() |>
    fs::path("output/SuStaIn-simulated-data/") |>
    extract_figs_from_pickle(output_folder = _) |>
    ggplot2::ggsave(
      filename = tempfile(),
      device = "svg",
      width = 10,
      height = 10
    ) |>
    expect_snapshot_file(name = "PVD.svg")
})
