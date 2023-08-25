get_biomarker_events_table = function(biomarker_levels)
{
  stack(biomarker_levels) |>
    tibble() |>
    rename(
      biomarker = ind,
      level = values) |>
    relocate(biomarker, .before = everything()) |>
    mutate(
      biomarker = factor(biomarker, levels = names(biomarker_levels)),
      level = level |> str_replace("Yes", "Present"),
      biomarker_level = paste(biomarker, level, sep = ": ")) |>
    mutate(level = row_number(), .by = biomarker) |>
    filter(level > 1) |>
    arrange(level, biomarker)

}
