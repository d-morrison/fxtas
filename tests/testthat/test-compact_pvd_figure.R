test_that("`compact_pvd_figure()` produces consistent results", {
  size.y = 11
  figs = extract_figs_from_pickle(
    use_rds = FALSE,
    size.y = size.y,
    n_s = 3,
    rda_filename = "data.RData",
    dataset_name = "sample_data",
    output_folder = fs::path_package("extdata/sim_data", package = "fxtas")
  )

  y_text_size = 11
  tile_height = 1
  # facet_label_size = 8
  facet_label_prefix = names(figs)
  legend.position = "none"
  scale_colors = c("red", "blue", "purple4")
  plot_dataset <- compact_pvd_data_prep(figs = figs)
  # facet labels
  facet_names <- compact_pvd_facet_labels(figs = figs, facet_label_prefix = facet_label_prefix)
  # generate figure
  compact_pvd_figure(
    plot_dataset,
    tile_height = tile_height,
    y_text_size = y_text_size,
    facet_names = facet_names,
    # facet_label_size = facet_label_size,
    legend.position = legend.position,
    scale_colors = scale_colors
  ) |>
    suppressWarnings() |> # todo: remove and fix labeller warning
    vdiffr::expect_doppelganger(title = "compact_pvd_figure")

})
