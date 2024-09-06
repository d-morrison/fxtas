#' Clean the variable `Gender`
#' @description
#' This function attempts to add the label "chromosomal sex",
#' but lots of functions remove attributes, such as [droplevels()]
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
clean_gender = function(data)
{
  data |>
    mutate(Gender = Gender |>
             structure(label = "Sex"))
}
