### clean Primary Ethnicity ###
clean_ethnicity <- function(dataset){
  dataset |>
    # recorde ethnicity factor levels
    # combine "Not Hispanic..." and "NOT Hispanic..."
    mutate(
      `Primary Ethnicity` = forcats::fct_recode(
        `Primary Ethnicity`,
        # `Not Hispanic or Latino` = "Not Hispanic or Latino",
        `Not Hispanic or Latino` = "NOT Hispanic or Latino"
      )
    )
}
