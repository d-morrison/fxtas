# update ApoE and CGG with data from Flora #
update_apoe <- function(dataset){
  # store ApoE levels from GP3/4 data
  apoe_levels <- levels(dataset$`ApoE (backfilled)`)

  # convert ApoE corrections to factor with consistent levels
  apoe <- apoe |>
    mutate(
      `ApoE (backfilled)` = factor(`ApoE (backfilled)`,
                                   levels = apoe_levels)
    )

  # replace ApoE values with ApoE corrections
  # https://stackoverflow.com/questions/40177132/replace-values-from-another-dataframe-by-ids

  # create empty ApoE updated with factor levels
  dataset$`ApoE (updated)` <- factor(NA, levels = apoe_levels)
  # fill in updated ApoE by ID
  dataset$`ApoE (updated)`[match(apoe$`FXS ID`, dataset$`FXS ID`)] <- apoe$`ApoE (backfilled)`

  # only inserts updated ApoE value into the first obs of a given ID, backfill
  dataset |>
    group_by(`FXS ID`) |>
    tidyr::fill(
      `ApoE (updated)`,
      .direction = "downup") |>
    # if ApoE (updated) is missing, fill with ApoE (backfilled)
    mutate(
      `ApoE (updated)` = dplyr::if_else(
        !is.na(`ApoE (updated)`),
        `ApoE (updated)`,
        `ApoE (backfilled)`
      )
    ) |>
    ungroup() |>
    # relocate ApoE (updated) to after ApoE (backfilled) and return
    relocate(`ApoE (updated)`, .after = `ApoE (backfilled)`)
}
