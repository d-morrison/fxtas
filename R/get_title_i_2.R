#' get title for PVD
#'
#' @param subtype_and_stage_table part of results [tibble::tbl_df]
#' @param cval [logical]
#' @param i [integer]
#'
#' @returns a [character] string
#' @dev
get_title_i_2 <- function(
    subtype_and_stage_table,
    cval = FALSE,
    i)
{

  subtype = paste("Type", i)
  n_s = attr(subtype_and_stage_table$ml_subtype, "n_s")

  if(n_s == 1)
  {
    n_samples = nrow(subtype_and_stage_table)
    title_i = glue::glue("n = {n_samples}")
  } else if(cval)
  {
    title_i = glue::glue("Subtype {i} cross-validated")

  } else
  {
    subtype_and_stage_table =
      subtype_and_stage_table |>
      dplyr::filter(ml_subtype != "Type 0")

    n_samples = nrow(subtype_and_stage_table)
    n_i = sum(
      subtype_and_stage_table$ml_subtype == subtype
    )

    p_i = formattable::percent(
      n_i / n_samples,
      digits = 1,
      drop0trailing = TRUE)

    if (is.finite(n_samples))
    {
      title_i = glue::glue(
        "Subtype {i} ({p_i}, n = {n_i})")
    } else
    {
      cli::cli_warn("not sure why this case is occurring; investigate.")
      title_i = glue::glue("Subtype {i} ({p_i})")
    }

  }

  return(title_i)

}
