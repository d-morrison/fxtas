fix_CGG = function(dataset)
{
  missingCGG = readxl::read_excel(
    "inst/extdata/Missing CGG repeat import_24Mar23.xlsx",
    sheet = "missing_CGG")

  colnames(missingCGG)[3] = "CGG (recovered)"

  # import additiona missingCGG data (10/2023)
  updatedCGG = readxl::read_xlsx(
    "inst/extdata/GP3 & GP4 - Missing CGG Data Samples Table - 10-9-2023-mdp.xlsx"
  ) |>
    mutate(
      Study = substr(`Event Name`, start = 1, stop = 3),
      # remove second FXS ID from "500011-608/108094-100" for now
      `FXS ID` = substr(`FXS ID`, start = 1, stop = 10),
      # convert "NA" string to NA_character
      `CGG (backfilled)` = dplyr::if_else(
        `CGG (backfilled)` == "NA",
        NA_character_,
        `CGG (backfilled)`
      )
    ) |>
    relocate(
      Study, .before = `FXS ID`
    ) |>
    rename(
      `CGG (recovered)` = `CGG (backfilled)`
    ) |>
    dplyr::select(
      all_of(colnames(missingCGG))
    )

  duplicates = missingCGG |> count(`FXS ID`) |> filter(n != 1)

  if(nrow(duplicates) != 0) browser(message("why are there duplicates?"))

  dataset |>
    left_join(
      missingCGG |> select(-Study),
      by = "FXS ID",
      relationship = "many-to-one"
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
        sapply(F = function(x) gsub(x = x, fixed = TRUE, ">", "")) |>
        sapply(F = as.numeric) |>
        suppressWarnings() |>
        sapply(F = max),

      `CGG: missingness reasons` =
        missingness_reasons.numeric(
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
