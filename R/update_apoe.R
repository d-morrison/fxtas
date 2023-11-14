# update ApoE and CGG with data from Flora #
update_apoe <- function(data){
  # store ApoE levels from GP3/4 data
  apoe_levels <- levels(data$`ApoE (backfilled)`)

  # convert ApoE corrections to factors with consistent levels
  apoe <- apoe |>
    mutate(
      `ApoE (backfilled)` = factor(`ApoE (backfilled)`,
                                   levels = apoe_levels)
    )

  # replace ApoE values with ApoE corrections
  # https://stackoverflow.com/questions/40177132/replace-values-from-another-dataframe-by-ids
  data$`ApoE (updated)` <- data$`ApoE (backfilled)`
  data$`ApoE (updated)`[match(apoe$`FXS ID`, data$`FXS ID`)] <- apoe$`ApoE (backfilled)`

  # relocate ApoE (updated) to after ApoE (backfilled) and return
  data |>
    relocate(`ApoE (updated)`, .after = `ApoE (backfilled)`)
}
