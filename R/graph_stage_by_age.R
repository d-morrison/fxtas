#' graph stage by age
#'
#' @param data
#' @param alpha
#'
#' @return
#' @export
#'
#' @examples
graph_stage_by_age = function(data,
                              alpha = .7)
{
  graph = data |>
    filter(ml_subtype != "Type 0") |>
    ggplot(
      aes(x = age,
          y = ml_stage)
    ) +
    geom_point(
      # aes(col = id),
      alpha = alpha) +
    # geom_line(
    #   aes(col = id, group = id),
    #   alpha = alpha) +
    geom_smooth(method = "loess", formula = y ~ x) +
    xlab("Age at visit (years)") +
    ylab("Estimated sequence stage") +
    ggplot2::theme_bw() +
    theme(legend.position = "none")

  n_subtypes = data |>
    filter(ml_subtype != "Type 0") |>
    pull(ml_subtype) |>
    dplyr::n_distinct()

  if(n_subtypes > 1)
  {
    graph = graph + ggplot2::facet_wrap(~ml_subtype)
  }
  return(graph)
}
