fix_CGG = function(dataset)
{
  missingCGG = readxl::read_excel(
    "inst/extdata/Missing CGG repeat import_24Mar23.xlsx",
    sheet = "missing_CGG")

  colnames(missingCGG)[3] = "CGG (recovered)"

  duplicates = missingCGG |> count(`FXS ID`) |> filter(n != 1)

  if(nrow(duplicates) != 0) browser(message("why are there duplicates?"))

  dataset |>
    left_join(
      missingCGG |> select(-Study),
      by = "FXS ID"
    ) |>
    mutate(
      `Floras Non-Sortable Allele Size (CGG) Results` =
        if_else(
          is.na(`Floras Non-Sortable Allele Size (CGG) Results`),
          `CGG (recovered)`,
          `Floras Non-Sortable Allele Size (CGG) Results`
        ),
      `CGG (recovered)` = NULL,
      CGG =
        `Floras Non-Sortable Allele Size (CGG) Results` |>
        strsplit(" *(\\)|-|,| ) *\\(?") |>
        sapply(F = function(x) gsub(x = x, fixed = TRUE, "?*", "")) |>
        sapply(F = as.numeric) |>
        suppressWarnings() |>
        sapply(F = max),

      `CGG: missingness` =
        missingness_reasons(
          x = `Floras Non-Sortable Allele Size (CGG) Results`,
          x.clean = CGG
        ),
      `CGG (backfilled)` = CGG
    )  |>
    relocate(
      `CGG (backfilled)`, .after = "CGG"
    ) |>
    group_by(`FXS ID`) |>
    tidyr::fill(
      `CGG (backfilled)`,
      .direction = "downup") |>
    mutate(
      `CGG (backfilled)` = `CGG (backfilled)` |> last() # more recent assays may be more accurate
    ) |>
    ungroup()
}
