#' Make demographics table
#'
#' @param data a [data.frame] containing the variables specified by
#' `strata` and `vars`
#' @param strata names of column variable, specified as [character]
#' @param vars names of row variables, specified as [character]
#' @inherit format_demographics_table_as_flextable return
#' @export
#'
#' @examples
#' test_data_v1 |> make_demographics_table()
make_demographics_table <- function(data,
                                    strata = "Gender",
                                    vars = c(# "Study",
                                      "Age at visit",
                                      # "# visits",
                                      # column_var,
                                      "Primary Race/Ethnicity",
                                      # "Primary Ethnicity",
                                      # "Primary Race",
                                      "FXTAS Stage",
                                      "CGG"
                                      # "ApoE")
                                    ))
{


  data_to_use = data |>
    dplyr::select(all_of(vars), Gender, `FX*`)
  # create table using gtsummary with p-value for sex difference

  table_function <- function(data) {
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
      strata = all_of(strata),
      .tbl_fun = ~ .x |>
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
      pvalue_fun = function(x)
        gtsummary::style_number(x, digits = 3)
    ) |>
    gtsummary::modify_column_hide(columns = c(stat_1, stat_2)) |>
    gtsummary::separate_p_footnotes(
      footnote_prefix = "p-value for significance of sex difference by ")

  to_return = list(tbl_stat, tbl_pval) |>
    gtsummary::tbl_merge(tab_spanner = FALSE) |>
    gtsummary::bold_labels() |>
    gtsummary::modify_footnote(
      "p.value_2" = paste(
        "p-values represent tests for sex differences in",
        "distributions of characteristics, all CGG repeat levels.")) |>
    format_demographics_table_as_flextable()

  return(to_return)

}
