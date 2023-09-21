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
      "Any tremor (excluding Head Tremor)" = case_when(
        dplyr::if_any(
          .cols = all_of(tremor_types),
          .fns = ~ . %in% "Yes"
        ) ~ "Some tremors recorded",
        dplyr::if_all(
          .cols = all_of(tremor_types),
          .fns = ~ is.na(.)
        ) ~ NA_character_,
        .default = "No tremors recorded"
      ) |>
        factor() |>
        relevel(ref = "No tremors recorded")
    )
}
