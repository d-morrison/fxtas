#' Clean the variable `Gender`
#' @description
#' This function attempts to add the label "chromosomal sex",
#' but lots of functions remove attributes, such as [droplevels()]
#'
#' @param data a [data.frame]
#'
#' @returns a modified version of `data`
#' @export
#'
#' @examples
#' test_data |> clean_gender()
clean_gender <- function(data)
{
  data |>
    mutate(
      Gender = .data$Gender |> labelled::set_label_attribute("Sex"),
      "Male" = .data$Gender == "Male")
}
