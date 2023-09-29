#' Categorize `CGG (backfilled)``
#'
#' Adds categorized versions of CGG to input dataset.
#'
#' @param dataset a tibble containing a numeric variable named `CGG (backfilled)`
#'
#' @return a tibble with the same columns as `dataset`, except with the following additions:
#' * FX (logical): TRUE if CGG >= 55
#' - `FX*` (factor): dichotomizes CGG to < 55 vs >= 55; `NA`s stay as `NA`
#' - `FX**` (factor): dichotomizes CGG to < 55 vs >= 55; `NA`s converted to level "CGG missing"
#' - `FX***` (factor): trichotomizes CGG to < 55, 55-100, and >100 >= 55; `NA`s converted to level "CGG missing"

#' @export
#'
define_cases_and_controls = function(dataset)
{
  dataset |>
    mutate(
      FX = `CGG (backfilled)` >= 55, # TRUE = cases
      `FX*` =
        if_else(FX, "CGG >= 55", "CGG < 55") |>
        factor() |>
        relevel(ref = "CGG < 55"),

      `FX**` =
        `FX*` |>
        forcats::fct_na_value_to_level(level = "CGG missing"),

      FX3 =
        case_when(
          `CGG (backfilled)` < 55 ~ "CGG < 55",
          `CGG (backfilled)` |> between(55, 100) ~ "CGG 55-100",
          `CGG (backfilled)` > 100 ~ "CGG > 100",
          is.na(`CGG (backfilled)`) ~ "CGG missing",
          .ptype = factor(
            levels = c(
              "CGG < 55",
              "CGG 55-100",
              "CGG > 100",
              "CGG missing")
          )
        )
    )


}
