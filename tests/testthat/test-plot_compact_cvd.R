test_that("`plot_compact_cvd()` produces consistent results", {
  fig1 <- fs::path_package("extdata/sim_data/", package = "fxtas") |>
    extract_figs_from_pickle(output_folder = _,
                             n_s = 2) |>
    plot_compact_pvd(scale_colors = c("red", "blue", "purple4"))
  fig1 <- ggplot2::ggsave(
    filename = tempfile(),
    device = "svg",
    width = 10,
    height = 10
  ) |>
    expect_snapshot_file(name = "PVD.svg")


})
