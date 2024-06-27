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
  vars = c(
    # "Study",
    "Age at visit",
    # "# visits",
    # column_var,
    "Primary Race/Ethnicity",
    # "Primary Ethnicity",
    # "Primary Race",
    "FXTAS Stage (0-5)*"
    # "ApoE"

  )

  # table1(
  #   na.is.category = FALSE, overall = FALSE,
  #   NA.label = "Missing",
  #   stratified_formula(vars, strata = "FX*"),
  #   # render.continuous = c(.="N", .="Mean (SD)", .="Median [Min,  Max]"),
  #   data = data)


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
          gtsummary::all_continuous() ~ c("{mean} ({sd})", "{median} [{min}, {max}]")
        ),
        digits = list(`Age at visit` ~ c(1, 2)),
        missing_text = "Missing"
      )
  )

  tbl_pval <- data |>
    dplyr::select(all_of(vars), Gender) |>
    gtsummary::tbl_summary(
      by = Gender,
      missing_text = "Missing"
    ) |>
    gtsummary::add_p(
      pvalue_fun = function(x) gtsummary::style_number(x, digits = 3)
    ) |>
    gtsummary::modify_column_hide(columns = c(stat_1, stat_2)) |>
    gtsummary::separate_p_footnotes()

  gtsummary::tbl_merge(
    list(tbl_stat, tbl_pval), tab_spanner = FALSE
  )
}
