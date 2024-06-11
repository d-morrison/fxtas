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
      `CGG (backfilled)` = dplyr::na_if(
        `CGG (backfilled)`,
        "NA"
      )
    ) |>
    dplyr::relocate(
      Study, .before = `FXS ID`
    ) |>
    dplyr::rename(
      `CGG (recovered)` = `CGG (backfilled)`
    ) |>
    dplyr::select(
      all_of(colnames(missingCGG))
    )

  # combine previous and updated missingCGG data
  # additional update should contain duplicates from previous missingCGG
  newCGG <- rbind(missingCGG, updatedCGG) |>
    arrange(`FXS ID`) |>
    # remove non-unique rows, e.g. still missing CGG
    unique() |>
    # add count
    add_count(`FXS ID`) |>
    # if count == 2, remove obs with missing CGG
    filter(
      !(n == 2 & is.na(`CGG (recovered)`))
    ) |>
    # remove count variable
    dplyr::select(-n)



  duplicates = newCGG |> count(`FXS ID`) |> filter(n != 1)

  if(nrow(duplicates) != 0) browser(message("why are there duplicates?"))

  dataset |>
    left_join(
      newCGG |> select(-Study),
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
        parse_CGG(),

      `CGG: missingness reasons` =
        missingness_reasons.numeric(
          x = `Floras Non-Sortable Allele Size (CGG) Results`,
          x.clean = CGG
        ),
      `CGG (backfilled)` = CGG
    )  |>
    dplyr::relocate(
      `CGG (backfilled)`, .after = "CGG"
    ) |>
    group_by(`FXS ID`) |>
    tidyr::fill(
      `CGG (backfilled)`,
      .direction = "downup") |>
    ungroup()  |>
    mutate(
      .by = `FXS ID`,
      `CGG (backfilled)` = `CGG (backfilled)` |> last() # more recent assays may be more accurate
    ) |>
    rename(
      `CGG (before backfill)` = CGG,
      CGG = `CGG (backfilled)`
    )
}
