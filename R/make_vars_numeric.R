make_vars_numeric = function(
    dataset,
    regex = "score",
    ignore.case = FALSE)
{
  dataset |>
    mutate(
      across(
        contains(regex, ignore.case = ignore.case),
        # c(
        #   `BDS-2 Total Score`,
        #   `MMSE Total Score`),
        list(
          missingness = missingness_reasons,
          tmp = clean_numeric),
        .names = "{.col}{if_else(.fn != 'tmp', paste0(': ', .fn), '')}"
      )
    )
}
