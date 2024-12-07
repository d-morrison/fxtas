#' Make biomarkers table
#'
#' @param biomarker_events_table [data.frame] from
#' [construct_biomarker_events_table()]
#' @param data a [data.frame()] containing the columns specified by
#' `biomarker_varnames` as well as `stratifying_var_names`
#' @param biomarker_varnames a [character] vector matching a subset of
#' the column names in `data`
#' @param stratifying_var_names a [character] vector specifying
#' variables to stratify by
#' @returns a [flextable::flextable()]
#' @export
#'
#' @examples
#' biomarker_group_list <- list(
#'   "group 1" = c("Biomarker 1", "Biomarker 2"),
#'   "group 2" = c("Biomarker 3", "Biomarker 4"),
#'   "group 3" = "Biomarker 5"
#' )
#' biomarker_groups <- compile_biomarker_groups_table(
#'   dataset = sim_data,
#'   biomarker_group_list = biomarker_group_list
#' )
#'
#' biomarker_varnames <-
#'   biomarker_groups |>
#'   dplyr::pull("biomarker")
#'
#' biomarker_levels <-
#'   sim_data |>
#'   get_levels(biomarker_varnames)
#'
#' biomarker_events_table <-
#'   construct_biomarker_events_table(
#'     biomarker_levels,
#'     biomarker_groups = biomarker_groups
#'   )
#'
#' sim_data |> make_biomarkers_table(
#'   biomarker_events_table = biomarker_events_table,
#'   biomarker_varnames = biomarker_varnames,
#'   stratifying_var_names = "Sex"
#' )
#'
make_biomarkers_table <- function(data,
                                  biomarker_varnames =
                                    compile_biomarker_groups_table() |>
                                    dplyr::pull("biomarker"),
                                  biomarker_events_table,
                                  stratifying_var_names = "Gender") {
  # compute p-values by gender
  pvals <- numeric()

  for (cur in biomarker_varnames) {
    pvals[cur] <-
      data |>
      dplyr::mutate(
        above_baseline = .data[[cur]] != levels(.data[[cur]])[1]) |>
      dplyr::select(all_of(c(
        "above_baseline", stratifying_var_names
      ))) |>
      table() |>
      fisher.test() |>
      magrittr::use_series("p.value")
  }

  probs_above_baseline_by_gender <-
    data |>
    dplyr::summarize(.by = all_of(stratifying_var_names), across(
      all_of(biomarker_varnames),
      ~ mean(.x != levels(.x)[1], na.rm = TRUE)
    ))

  probs_above_baseline_by_gender <-
    probs_above_baseline_by_gender |>
    pivot_longer(cols = -all_of(c(stratifying_var_names)),
                 names_to = "biomarker",
                 values_to = "Pr(above_baseline)")

  probs_above_baseline_by_gender <-
    probs_above_baseline_by_gender |>
    dplyr::mutate(
      # probably want to apply formatting here (after pivoting)
      # rather than during the summarize step,
      # so that accuracy is applied per-column:
      `Pr(above_baseline)` =
        .data$`Pr(above_baseline)` |>
        formattable::percent(drop0trailing = TRUE, digits = 1)
    )

  probs_above_baseline_by_gender <-
    probs_above_baseline_by_gender |>
    pivot_wider(
      id_cols = "biomarker",
      names_from = all_of(stratifying_var_names),
      values_from = all_of("Pr(above_baseline)")
    ) |>
    dplyr::mutate("p-value" = pvals[.data$biomarker])

  table_out <-
    biomarker_events_table |>
    dplyr::select(all_of(c("category" = "biomarker_group",
                           "biomarker", "levels"))) |>
    slice_head(by = "biomarker") |>
    dplyr::filter(.data$category != "Stage") |>
    left_join(y = probs_above_baseline_by_gender,
              by = "biomarker",
              relationship = "one-to-one") |>
    dplyr::mutate(biomarker =
                    .data$biomarker |>
                    sub(
                      pattern = "*",
                      replacement = "",
                      fixed = TRUE
                    ) |>
                    stringr::str_replace(
                      stringr::fixed("SCID: "),
                      ""
                    ))

  table_out |>
    structure(class = union("biomarkers_table", class(table_out)))
}
