#' Create table of demographics statistics by most-likely latent subtype
#'
#' @param patient_data a [data.frame]
#' @param subtype_and_stage_table a [data.frame]
#' @param footnotes_as_letters [logical] whether to convert footnote
#' symbols to letters (TRUE) instead of numbers (FALSE)
#' @returns A [gtsummary::tbl_summary]
#' @export
#' @examples
#' patient_data = test_data_v1 |> filter(CGG >= 55, CGG < 200)
#' table = test_subtype_and_stage_table
#' table_subtype_by_demographics(patient_data, table)
#' @inheritDotParams gtsummary::tbl_summary

table_subtype_by_demographics = function(
    patient_data,
    subtype_and_stage_table,
    footnotes_as_letters = FALSE,
    ...
)
{

  patient_data2 =
    patient_data |>
    bind_cols(subtype_and_stage_table) |>
    mutate("Male" = .data$Gender == "Male",
           "CGG 100-199" = .data$`FX3*` == "CGG 100-199",
           "CGG 55-99" = .data$`FX3*` == "CGG 55-99")

  # simulated_fisher <- function(data, variable, by, ...){
  #   data <- data[c(variable, by)]
  #   stats::fisher.test(
  #     data[[variable]], as.factor(data[[by]]), simulate.p.value = TRUE, B = 10000,
  #     conf.level = 0.95
  #   ) |>
  #     broom::tidy()
  # }

  to_return =
    patient_data2 |>
    filter(ml_subtype != "Type 0") |>
    drop_levels() |>
    dplyr::select(
      all_of(
        c(
          "ml_subtype", "CGG", "CGG 55-99", "Male", "Primary Race/Ethnicity"))) |>
    gtsummary::tbl_summary(
      by = ml_subtype,
      percent = "column", # revert back to column percentages
      # type = list(Gender ~ "dichotomous"),
      # value = list(Gender ~ "Female"),
      statistic = list(
        gtsummary::all_continuous() ~ "{mean} ({sd})"
      ),
      # missing = "no" # do not show missing
      missing_text = "Missing",
      ...
    ) |>

    gtsummary::add_p(
      pvalue_fun = function(x) gtsummary::style_number(x, digits = 3),
      test = list(CGG = "oneway.test"),
      test.args = c(`Primary Race/Ethnicity`) ~ list(simulate.p.value = TRUE)
    ) |>
    gtsummary::add_stat_label(location = "row") |>
    gtsummary::add_overall() |>
    gtsummary::modify_footnote(
      gtsummary::all_stat_cols() ~ "n (column %)") |>
    gtsummary::separate_p_footnotes(
      footnote_prefix = "Group comparison was done by"
    )

  if(footnotes_as_letters)
  {
    to_return = to_return |>
      gtsummary::as_gt() |>
      gt::opt_footnote_marks(marks = "letters")
  }

  # to_return$table_body[1, "stat_1"] =
  #   paste(to_return$table_body[1, "stat_1"], "#")
  #
  # to_return$table_body[1, "stat_1"] =
  #   paste(to_return$table_body[1, "stat_1"], "#")

  # to_return = to_return
  return(to_return)

}
