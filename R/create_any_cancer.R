create_any_cancer = function(
    dataset,
    cancer_types = c(
      "Thyroid Cancer",
      "Skin Cancer",
      "Melanoma",
      "Prostate Cancer",
      "Other Cancer"
    )
)
{
  dataset |>
    mutate(
      "Any Cancer" = case_when(
        dplyr::if_any(
          .cols = all_of(cancer_types),
          .fns = ~ . %in% "Yes"
        ) ~ "Some cancers recorded",
        dplyr::if_all(
          .cols = all_of(cancer_types),
          .fns = ~ is.na(.)
        ) ~ NA,
        TRUE ~ "No cancers recorded"
      )
    )
}
