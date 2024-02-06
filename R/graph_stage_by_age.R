#' graph stage by age
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
graph_stage_by_age = function(data)
{
  data |>
    filter(ml_subtype != "Type 0") |>
    ggplot(
      aes(x = age,
          y = ml_stage)
    ) +
    geom_point() +
    facet_wrap(~ml_subtype) +
    geom_smooth() +
    xlab("Age at visit (years)")
}
