choose_biomarker_group_colors = function(biomarker_groups)
{
  tibble(
    biomarker_group = biomarker_groups) |>
    mutate(
    # group_color = rainbow()
    group_color =
    # RColorBrewer::brewer.pal(n = n(), name = "Paired")
    # rcartocolor::carto_pal(n = _, "Safe")
    colorspace::qualitative_hcl(n = n(), "Dark2")
  )
}