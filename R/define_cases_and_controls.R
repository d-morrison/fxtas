#' Categorize `CGG``
#'
#' Adds categorized versions of CGG to input dataset.
#'
#' @param dataset a tibble containing a numeric variable named `CGG`
#'
#' @return a tibble with the same columns as `dataset`, except with the following additions:
#' * FX (logical): TRUE if CGG >= 55
#' - `FX*` (factor): dichotomizes CGG to < 55 vs >= 55; `NA`s stay as `NA`
#' - `FX**` (factor): dichotomizes CGG to < 55 vs >= 55; `NA`s converted to level `"CGG missing"`
#' - `FX3*` (factor): trichotomizes CGG to < 55, 55-100, and >100 >= 55; `NA`s stay as NAs
#' - `FX3**` (factor): trichotomizes CGG to < 55, 55-100, and >100 >= 55; `NA`s converted to level "CGG missing"

#' @export
#'
define_cases_and_controls = function(dataset)
{
  dataset |>
    mutate(
      FX = `CGG` >= 55, # TRUE = cases
      `FX*` =
        if_else(FX, "CGG >= 55", "CGG <55") |>
        factor() |>
        relevel(ref = "CGG <55"),

      `FX**` =
        `FX*` |>
        forcats::fct_na_value_to_level(level = "CGG missing"),

      `FX3*` =
        case_when(
          `CGG` < 55 ~ "CGG <55",
          `CGG` |> between(55, 99) ~ "CGG 55-99",
          `CGG` |> between(100, 199) ~ "CGG 100-199",
          `CGG` >= 200 ~ "CGG >= 200",
          .ptype = factor(
            levels = c(
              "CGG <55",
              "CGG 55-99",
              "CGG 100-199",
              "CGG >= 200")
          )
        ) |> labelled::set_label_attribute("CGG repeat size"),

      `FX3**` =
        case_when(
          `CGG` < 55 ~ "CGG <55",
          `CGG` |> between(55, 99) ~ "CGG 55-99",
          `CGG` |> between(100, 199) ~ "CGG 100-199",
          `CGG` >= 200 ~ "CGG >= 200",
          is.na(`CGG`) ~ "CGG missing",
          .ptype = factor(
            levels = c(
              "CGG <55",
              "CGG 55-99",
              "CGG 100-199",
              "CGG >= 200",
              "CGG missing")
          )
        ),

      "CGG 100-199" = .data$`FX3*` == "CGG 100-199",
      "CGG 55-99" = .data$`FX3*` == "CGG 55-99"

    )


}
