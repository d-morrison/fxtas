missing_codes_to_NA <- function(
    x,
    NA_codes = c(777, 888, 999,
                 "Question not asked at time of data entry; check records (777)",
                 "NA (888)",
                 "No Response (999)", extra_codes),
    extra_codes = NULL)
  {

    if_else(
      x %in% NA_codes,
      NA,
      x)
  }

