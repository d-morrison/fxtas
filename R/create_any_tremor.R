create_any_tremor = function(
    dataset,
    tremor_types = c(
      "Intention tremor",
      "Resting tremor",
      "Postural tremor",
      "Intermittent tremor"
    )
)
{
  dataset |>
    mutate(
      "Any tremor" = dplyr::if_any(
        .cols = all_of(tremor_types),
        .fns = ~ . %in% "Yes") |>
        if_else("Some Tremors Recorded", "No Tremors Recorded")
    )
}
