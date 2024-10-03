choose_biomarker_group_colors = function(
    biomarker_groups,
    biomarker_group_names =
      biomarker_groups |>
      names())
{
  tibble(
    biomarker_group = biomarker_group_names) |>
    mutate(
    # group_color = rainbow()
    group_color =
    # RColorBrewer::brewer.pal(n = n(), name = "Paired")
    # rcartocolor::carto_pal(n = _, "Safe")
    colorspace::qualitative_hcl(n = dplyr::n(), "Dark2")
  )
}
