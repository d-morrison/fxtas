make_vars_numeric <- function(
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
        #   `MMSE total score`),
        list(
          tmp = clean_numeric,
          `missingness reasons` = missingness_reasons.numeric),
        .names = "{.col}{if_else(.fn != 'tmp', paste0(': ', .fn), '')}"
      )
    )
}
