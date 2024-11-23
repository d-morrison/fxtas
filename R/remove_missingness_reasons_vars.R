#' Remove variable
#'
#' @param vars a [character()] vector
#'
#' @returns a modified version of input `vars` ([character()]) with elements ending in "missingness reasons" removed
#' @export
#'
#' @examples
#' vars = c(
#' "parkinsonian features",
#' "parkinsonian features: missingness reasons")
#' vars |> remove_missingness_reason_vars()
remove_missingness_reason_vars <- function(vars)
{
  vars |>
    grep(
      pattern = "missingness reasons$",
      invert = TRUE,
      value = TRUE)
}
