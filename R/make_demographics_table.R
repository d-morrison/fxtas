#' Make demographics table
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
#' test_data_v1 |> make_demographics_table()
make_demographics_table = function(data)
{
  vars = c(# "Study",
    "Age at visit",
    # "# visits",
    # column_var,
    "Primary Race/Ethnicity",
    # "Primary Ethnicity",
    # "Primary Race",
    "FXTAS Stage (0-5)*",
    "CGG"
    # "ApoE")
  )

  data_to_use = data |>
    dplyr::select(all_of(vars), Gender, `FX*`)
  # create table using gtsummary with p-value for sex difference

  table_function = function(data) {
    data |>
      gtsummary::tbl_summary(
        by = `FX*`,
        type = gtsummary::all_continuous() ~ "continuous2",
        statistic = list(
          gtsummary::all_continuous() ~
            c("{mean} ({sd})", "{median} [{min}, {max}]")
        ),
        # round mean to 1 digit, SD to 2 digits, Median and Range to 0
        digits = list(`Age at visit` ~ c(1, 2, 0, 0, 0), CGG ~ c(1, 2, 0, 0, 0)),
        missing_text = "Missing"
      )
  }

  tbl_stat <-
    gtsummary::tbl_strata(
      data = data_to_use,
      strata = c("Gender"),
      .tbl_fun = ~ .x %>%
        gtsummary::tbl_summary(
          by = `FX*`,
          type = gtsummary::all_continuous() ~ "continuous2",
          statistic = list(
            gtsummary::all_continuous() ~
              c("{mean} ({sd})", "{median} [{min}, {max}]")
          ),
          # round mean to 1 digit, SD to 2 digits, Median and Range to 0
          digits = list(`Age at visit` ~ c(1, 2, 0, 0, 0), CGG ~ c(1, 2, 0, 0, 0)),
          missing_text = "Missing"
        )
    )

  tbl_pval <- data |>
    dplyr::select(all_of(vars), Gender) |>
    gtsummary::tbl_summary(by = Gender, missing_text = "Missing") |>
    gtsummary::add_p(
      # test = `Age at visit` ~ "add_p_test_wilcox.test2",
      test.args =
        list(
        `Age at visit` ~
        list(method = "p-value for significance of
             sex difference by Wilcoxon rank sum test"),
        `Primary Race/Ethnicity` ~
        list(method = "p-value for significance of
             sex difference by fisher rank sum test")
        # gtsummary::all_tests("fisher.test") ~
        #   list(method = "p-value for significance of sex difference by Fisher's exact test")
        ),
      pvalue_fun = function(x)
        gtsummary::style_number(x, digits = 3)
    ) |>
    gtsummary::modify_column_hide(columns = c(stat_1, stat_2)) |>
    gtsummary::separate_p_footnotes()

  to_return = list(tbl_stat, tbl_pval) |>
    gtsummary::tbl_merge(tab_spanner = FALSE) |>
    format_demographics_table_as_flextable()

  return(to_return)

}
