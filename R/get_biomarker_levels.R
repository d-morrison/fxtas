#' Extract levels from a set of variable names
#'
#' @param data a [data.frame]
#' @param varnames a [character] specifying which columns of `data` to analyze
#' @param keep_labels [logical] whether to preserve variable labels from `data` in output
#' @returns a [list] of [character] vectors containing the levels of the columns in `data` specified by `varnames`
#' @export
#'
#' @examples
#' get_levels(iris, "Species")
get_levels <- function(data, varnames = names(data), keep_labels = FALSE)
{

  vars = data |>
    dplyr::select(all_of(varnames))

  to_return =
    vars |>
    lapply(F = levels)


  if(keep_labels)
  {
    labels = labelled::var_label(vars)


    for (cur in names(labels))
    {
      labelled::var_label(to_return[[cur]]) = labels[[cur]]
    }

  }

  to_return
}
