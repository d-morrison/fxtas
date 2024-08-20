test_that("`extract_figs_from_pickle()` produces stable results", {
  here::here() |>
    fs::path("output/output.fixed_CV") |>
    extract_figs_from_pickle(output_folder = _) |>
    ggsave(
      filename = tempfile(),
      device = "svg",
      width = 10,
      height = 10
    ) |>
    expect_snapshot_file(name = "PVD.svg")
})
