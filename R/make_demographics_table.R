#' Make demographics table
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
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
    # "ApoE"
  )

  # create table using gtsummary with p-value for sex difference
  tbl_stat <- gtsummary::tbl_strata(
    data = data |>
      dplyr::select(all_of(vars), Gender, `FX*`),
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
        digits = list(
          `Age at visit` ~ c(1, 2, 0, 0, 0),
          CGG ~ c(1, 2, 0, 0, 0)),
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
    gtsummary::separate_p_footnotes()

  gtsummary::tbl_merge(list(tbl_stat, tbl_pval), tab_spanner = FALSE) |>
    gtsummary::as_flex_table() |>
    # update upper header label: '' to 'M vs. F'
    flextable::compose(
      part = "header",
      i = 1,
      j = "p.value_2",
      value = flextable::as_paragraph(
        "M vs. F"
      )
    ) |>
    # update lower header label: 'p-value' to 'p-value*'
    flextable::compose(
      part = "header",
      i = 2,
      j = "p.value_2",
      value = flextable::as_paragraph(
        "p-value", flextable::as_sup("*")
      )
    ) |>
    # reset p-value header column to bold font
    flextable::bold(part = "header", j = 6)
}
