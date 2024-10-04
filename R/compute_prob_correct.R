#' Compute each biomarker's probability of being recorded at its baseline level
#'
#' @param dataset a [data.frame()]; should be just control data
#' @param biomarker_levels a list containing the levels of each biomarker
#' @param max_prob a maximum value for the baseline probability
#'
#' @returns a named [numeric()] vector corresponding to the elements of `biomarker_levels`
#' @export
#'
compute_prob_correct = function(dataset, biomarker_levels, max_prob = 1)
{
  # check that all biomarkers are factors:

  is_factor =
    dataset |> select(all_of(biomarker_levels |> names())) |>
    sapply(F = is.factor)

  if (any(!is_factor))
  {
    cli::cli_abort(
      class = 'non-factor',
      "The following biomarkers are not factors: {names(is_factor)[!is_factor]}"
    )
  }

  # a [character()] vector of biomarker variable names:
  biomarkers = names(biomarker_levels)

  results = tibble()

  for (cur_biomarker in biomarkers)
  {
    x = dataset |> pull(cur_biomarker)
    cur_results = tibble(
      biomarker = cur_biomarker,
      `# obs` = sum(!is.na(x)),
      `# at baseline` = sum(x == levels(x)[1], na.rm = TRUE),
      `# elevated` = sum(x != levels(x)[1], na.rm = TRUE),
      `% at baseline` = mean(x == levels(x)[1], na.rm = TRUE),
      prob_correct = `% at baseline` |> min(max_prob, na.rm = TRUE) |>
        set_names(cur_biomarker)
    )

    results = results |>
      bind_rows(cur_results)

  }

  to_return = results$prob_correct |>
    structure(
    class = "prob_correct",
    data = results

  )

  return(to_return)
}
