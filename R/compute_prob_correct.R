#' Compute each biomarker's probability of being recorded at its baseline level
#'
#' @param dataset a [data.frame()]; should be just control data
#' @param biomarker_levels a list containing the levels of each biomarker
#' @param max_prob a maximum value for the baseline probability
#'
#' @returns a [structure()] that is fundamentally a named [numeric()] vector
#' corresponding to the elements of `biomarker_levels`,
#' but also contains a [tibble::tbl_df] as attribute `data`
#' (easier than fixing all uses of this function)
#' @export
#' @examples
#' full_data <- test_data_v1
#' v1_usable <- full_data |> dplyr::filter(CGG < 200)
#'
#' biomarker_groups <- compile_biomarker_groups_table()
#'
#' biomarker_varnames <-
#'   biomarker_groups |>
#'   pull("biomarker")
#'
#' biomarker_levels <-
#'   v1_usable |>
#'   dplyr::select(all_of(biomarker_varnames)) |>
#'   lapply(F = levels)
#'
#' control_data <-
#'   v1_usable |>
#'   dplyr::filter(`FX*` == "CGG <55") |>
#'   select(all_of(biomarker_varnames))
#'
#' control_data |>
#'   compute_prob_correct(
#'     max_prob = .95,
#'     biomarker_levels = biomarker_levels
#'   ) |>
#'   attr("data")
#'
compute_prob_correct <- function(dataset, biomarker_levels, max_prob = 1) {
  # check that all biomarkers are factors:

  is_factor <-
    dataset |>
    select(all_of(names(biomarker_levels))) |>
    sapply(F = is.factor)

  if (any(!is_factor)) {
    cli::cli_abort(
      class = "non-factor",
      "The following biomarkers are not factors: {names(is_factor)[!is_factor]}"
    )
  }

  # a [character()] vector of biomarker variable names:
  biomarkers <- names(biomarker_levels)

  results <- tibble()

  for (cur_biomarker in biomarkers) {
    x <- dataset |> pull(cur_biomarker)
    cur_results <- tibble(
      biomarker = cur_biomarker,
      `# obs` = sum(!is.na(x)),
      `# at baseline` = sum(x == levels(x)[1], na.rm = TRUE),
      `# elevated` = sum(x != levels(x)[1], na.rm = TRUE),
      `% at baseline` = mean(x == levels(x)[1], na.rm = TRUE),
      prob_correct = .data$`% at baseline` |>
        pmin(max_prob, na.rm = TRUE) |>
        set_names(cur_biomarker)
    )

    results <- results |>
      bind_rows(cur_results)
  }

  mapping =
    dataset[,biomarkers] |> sapply(F = labelled::get_label_attribute) |>
    unlist()

  mapping = c(names(mapping)) |> rlang::set_names(mapping)

  results$biomarker =
    results$biomarker |>
    labelled::add_value_labels(mapping)


  probs = results$prob_correct

  results <-
    results |>
    mutate(
      `% at baseline` = round(.data$`% at baseline` * 100, 1) |> paste0("%"),
      prob_correct = round(.data$prob_correct * 100, 1) |> paste0("%")
    ) |>
    select(
      all_of(
        c(
      Biomarker = "biomarker",
      `# controls with data` = "# obs",
      "# at baseline",
      "% at baseline",
      "Est. Pr(correct)" = "prob_correct"
    )))

  to_return <- probs |>
    structure(
      class = "prob_correct",
      data = results
    )

  return(to_return)
}

#' @title Print `prob_correct` objects as Pandoc markdown tables
#' @description This function is a method of the [pander::pander()] function
#' from the  `pander` package, for `prob_correct` objects
#' (from [compute_prob_correct()]).
#' It prints `prob_correct` objects as Pandoc markdown tables.
#' @param x a `prob_correct` object (from [compute_prob_correct()])
#' @param ... currently unused
#'
#' @return
#' @export
#'
#' @examples
#' full_data <- test_data_v1
#' v1_usable <- full_data |> dplyr::filter(CGG < 200)
#'
#' biomarker_groups <- compile_biomarker_groups_table()
#'
#' biomarker_varnames <-
#'   biomarker_groups |>
#'   pull("biomarker")
#'
#' biomarker_levels <-
#'   v1_usable |>
#'   dplyr::select(all_of(biomarker_varnames)) |>
#'   lapply(F = levels)
#'
#' control_data <-
#'   v1_usable |>
#'   dplyr::filter(`FX*` == "CGG <55") |>
#'   select(all_of(biomarker_varnames))
#'
#' control_data |>
#'   compute_prob_correct(
#'     max_prob = .95,
#'     biomarker_levels = biomarker_levels
#'   ) |>
#'   attr("data") |>
#'   pander()
#'
pander.prob_correct <- function(x, ...) {
  x |>
    attr("data") |>
    pander::pander()
}
