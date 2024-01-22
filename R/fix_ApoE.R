fix_ApoE = function(dataset)
{
  dataset |>
    mutate(
      ApoE =
        ApoE |>
        strsplit(", ") |>
        sapply(sort) |>
        sapply(paste, collapse = ", ") |>
        na_if(""),

      ApoE = factor(ApoE, levels = sort(unique(ApoE))),

      `ApoE*` = ApoE

      ) |>
    dplyr::relocate(
      `ApoE*`, .after = "ApoE"
    ) |>
    group_by(`FXS ID`) |>
    tidyr::fill(
      `ApoE*`,
      .direction = "downup") |>
    ungroup()


}
