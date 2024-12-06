## pairwise comparisons for latent sub-types
## compare sub-type proportions to overall proportion

test_obj <- table_subtype_by_demographics(
  patient_data,
  subtype_and_stage_table =
    results_cv_max$subtype_and_stage_table
)

# extract info for pairwise comparisons between sub-type and overall props
## CGG
names(test_obj$meta_data$df_stats) <- test_obj$meta_data$variable

p_0 <- test_obj$meta_data$df_stats[["FX3*"]] |>
  dplyr::filter(is.na(by), variable_levels == "CGG 100-199") |>
  dplyr::pull(p) |>
  unique()

pairwise_prop <- function(tbl_obj, var, var_level, subtype, p_0){
  prop.test(
    x = test_obj$meta_data$df_stats[[var]] |>
      dplyr::filter(by == subtype, variable_levels == var_level) |>
      dplyr::pull(n),
    n = test_obj$meta_data$df_stats[[var]] |>
      dplyr::filter(by == subtype, variable_levels == var_level) |>
      dplyr::pull(N),
    p = p_0
  )
}

subtype1 <- pairwise_prop(
  tbl_obj = test_obj, var = "FX3*", var_level = "CGG 100-199",
  subtype = "Type 1", p_0 = p_0
)
subtype2 <- pairwise_prop(
  tbl_obj = test_obj, var = "FX3*", var_level = "CGG 100-199",
  subtype = "Type 2", p_0 = p_0
)
subtype3 <- pairwise_prop(
  tbl_obj = test_obj, var = "FX3*", var_level = "CGG 100-199",
  subtype = "Type 3", p_0 = p_0
)
subtype4 <- pairwise_prop(
  tbl_obj = test_obj, var = "FX3*", var_level = "CGG 100-199",
  subtype = "Type 4", p_0 = p_0
)




#### brute force ####
## CGG as numeric
one_samp_ttest <- function(x, s, n, mu_0){
  t <- (x - mu_0) / (s / sqrt(n))
  df <- n - 1
  p_val <- 2 * pt(abs(t), df = df, lower = FALSE)

  return(
    list(
      'Mean' = x,
      'Alternative' = mu_0,
      `t-statistic` = t,
      df = df,
      `p-value` = p_val
    )
  )
}

# sub-type 1
one_samp_ttest(
  x = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 1") |>
    dplyr::pull(mean) |>
    as.character() |>
    as.numeric(),
  s = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 1") |>
    dplyr::pull(sd) |>
    as.character() |>
    as.numeric(),
  n = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 1") |>
    dplyr::pull(N_nonmiss) |>
    as.character() |>
    as.numeric(),
  mu_0 = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(is.na(by)) |>
    dplyr::pull(mean) |>
    as.character() |>
    as.numeric()
)
# sub-type 2
one_samp_ttest(
  x = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 2") |>
    dplyr::pull(mean) |>
    as.character() |>
    as.numeric(),
  s = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 2") |>
    dplyr::pull(sd) |>
    as.character() |>
    as.numeric(),
  n = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 2") |>
    dplyr::pull(N_nonmiss) |>
    as.character() |>
    as.numeric(),
  mu_0 = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(is.na(by)) |>
    dplyr::pull(mean) |>
    as.character() |>
    as.numeric()
)
# sub-type 3
one_samp_ttest(
  x = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 3") |>
    dplyr::pull(mean) |>
    as.character() |>
    as.numeric(),
  s = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 3") |>
    dplyr::pull(sd) |>
    as.character() |>
    as.numeric(),
  n = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 3") |>
    dplyr::pull(N_nonmiss) |>
    as.character() |>
    as.numeric(),
  mu_0 = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(is.na(by)) |>
    dplyr::pull(mean) |>
    as.character() |>
    as.numeric()
)
# sub-type 4
one_samp_ttest(
  x = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 4") |>
    dplyr::pull(mean) |>
    as.character() |>
    as.numeric(),
  s = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 4") |>
    dplyr::pull(sd) |>
    as.character() |>
    as.numeric(),
  n = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(by == "Type 4") |>
    dplyr::pull(N_nonmiss) |>
    as.character() |>
    as.numeric(),
  mu_0 = test_obj$meta_data$df_stats$CGG |>
    dplyr::filter(is.na(by)) |>
    dplyr::pull(mean) |>
    as.character() |>
    as.numeric()
)


## CGG: let 100-199 be 'success'
p_0 <- 55 / 217
# sub-type 1
prop.test(x = 14, n = 63, p = p_0)
# sub-type 2
prop.test(x = 20, 64, p = p_0)
# sub-type 3
prop.test(x = 14, 50, p = p_0)
# sub-type 4
prop.test(x = 7, 40, p = p_0)

## Gender: let Male be 'success'
p_0 <- 140 / 217
# sub-type 1
prop.test(x = 41, n = 63, p = p_0)
# sub-type 2
prop.test(x = 34, 64, p = p_0)
# sub-type 3
prop.test(x = 41, 50, p = p_0)
# sub-type 4
prop.test(x = 24, 40, p = p_0)

## pairwise gender comp
# 1 v 2
chisq.test(
  matrix(
    c(41, 22, 34, 30),
    nrow = 2, ncol = 2
  )
)

# 1 v 3
chisq.test(
  matrix(
    c(41, 22, 41, 9),
    nrow = 2, ncol = 2
  )
)

# 1 v 4
chisq.test(
  matrix(
    c(41, 22, 24, 16),
    nrow = 2, ncol = 2
  )
)

# 2 v 3
chisq.test(
  matrix(
    c(34, 30, 41, 9),
    nrow = 2, ncol = 2
  )
)

# 2 v 4
chisq.test(
  matrix(
    c(34, 30, 24, 16),
    nrow = 2, ncol = 2
  )
)

# 3 v 4
chisq.test(
  matrix(
    c(41, 9, 24, 16),
    nrow = 2, ncol = 2
  )
)


# add asterisk if significant
test_change <- test_obj
test_change$table_body <- test_change$table_body |>
  dplyr::mutate(
    stat_1 = dplyr::case_when(
      variable == "CGG" ~ paste0(stat_1, "*"),
      .default = stat_1
    )
  )

test_change


test_flex <- test_obj |>
  gtsummary::as_flex_table()

test_flex

test_flex |>
  flextable::mk_par(
    i = 1, j = "stat_1",
    value = flextable::as_paragraph(
      flextable::as_chunk(test_flex$body$dataset$stat_1[1]), flextable::as_sup("*")
    )
  )

test_flex$body$dataset <- test_flex$body$dataset |>
  dplyr::mutate(
    stat_1 = dplyr::case_when(
      label == "CGG" ~ paste0("Test Change"),
      .default = stat_1
    )
  )

test_flex$body$content$content$data[[13]] <- "Test"


View(test_flex$body$dataset)




subtype_cgg_aov <- aov(CGG ~ ml_subtype, data = patient_data2 |> dplyr::filter(ml_subtype != "Type 0"))
summary(subtype_cgg_aov)

## kyoungmi wants this updated to pairwise without correction ##
TukeyHSD(subtype_cgg_aov)






# test function

subtype_table <- function(
    patient_data,
    subtype_and_stage_table
){
  patient_data2 =
    patient_data |>
    bind_cols(subtype_and_stage_table)

  tbl <- patient_data2 |>
    dplyr::filter(ml_subtype != "Type 0") |>
    droplevels() |>
    dplyr::select(ml_subtype, CGG, `FX3*`, Gender, `Primary Race/Ethnicity`) |>
    gtsummary::tbl_summary(
      by = ml_subtype,
      percent = "column", # revert back to column percentages
      statistic = list(
        gtsummary::all_continuous() ~ "{mean} ({sd})"
      ),
      # missing = "no" # do not show missing
      missing_text = "Missing"
    ) |>

    gtsummary::add_p(
      pvalue_fun <- function(x) gtsummary::style_number(x, digits = 3),
      test = list(CGG = "oneway.test"),
      test.args = c(`Primary Race/Ethnicity`) ~ list(simulate.p.value = TRUE)
    ) |>
    gtsummary::add_overall()

  ## conduct pairwise comparisons: subtype vs overall ##
  # extract summary statistics, returns a list (length = # variables)
  stat_list <- tbl$meta_data$df_stats
  # update names of list
  names(stat_list) <- tbl$meta_data$variable



}
