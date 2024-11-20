fix_ApoE <- function(dataset)
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

      `ApoE (original)` = ApoE,
    ) |>
    dplyr::relocate(
      `ApoE (original)`, .after = "ApoE"
    ) |>
    group_by(`FXS ID`) |>
    tidyr::fill(
      `ApoE`,
      .direction = "downup") |>
    ungroup() |>
    mutate(
      .by = `FXS ID`,
      `ApoE` = `ApoE` |> last() # more recent assays may be more accurate
    )


}
