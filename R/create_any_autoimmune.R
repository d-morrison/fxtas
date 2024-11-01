create_any_autoimmune = function(
    dataset,
    autoimmune_dz = c(
      "Lupus",
      "Rheumatoid arthritis",
      "Multiple Sclerosis: Workup",
      "ANA positive",
      "Sjogrens Syndrome",
      "Raynauds Syndrome",
      "Pulmonary Fibrosis"
    )
)
{
  dataset |>
    mutate(
      "any autoimmune disorder" = case_when(
        dplyr::if_any(.cols = all_of(autoimmune_dz), .fns = ~ . %in% "Yes") ~ "Yes",
        dplyr::if_all(.cols = all_of(autoimmune_dz), .fns = ~ is.na(.)) ~ NA_character_,
        .default = "No"
      ) |>
        factor() |>
        relevel(ref = "No")
    )
}
