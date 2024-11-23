remove_unneeded_records <- function(dataset)
{
  dataset |>
    filter(
      # duplicate of GP4 visit 1; note from Ellery Santos, 2022-12-19, in word doc:
      not(`FXS ID` == "100429-700" & `Event Name` == "GP3 - Visit 1"),
      # note from Ellery Santos, 2022-12-19, in word doc:
      `FXS ID` != "500011-190",
      `FXS ID` != "999999-999"
    )
}
