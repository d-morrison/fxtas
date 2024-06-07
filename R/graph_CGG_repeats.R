#' Barplot of CGG repeats
#'
#' @param data a [data.frame] containing a [numeric] or [integer] column named `CGG`
#' @param include_200_cutoff whether to include the `CGG = 200` cutoff
#' @inheritParams ggplot2::facet_grid
#' @return a [ggplot2::ggplot] object
#' @export
#'
#' @examples
#' visit1 |> graph_CGG_repeats()
#' visit1 |> graph_CGG_repeats(cols = vars(Gender))
graph_CGG_repeats = function(
    data,
    rows = NULL,
    cols = NULL,
    include_200_cutoff = FALSE
)
{
  plot1 =
    data |>
    ggplot(aes(x = .data$CGG)) +
    geom_bar(alpha = .5) +
    geom_vline(
      data = tibble(
        x = c(
          55,
          100,
          if(include_200_cutoff) 200
        ),
        col = c(
          "55 CGG repeats",
          "100 CGG repeats",
          if(include_200_cutoff) "200 CGG repeats"
        ) |>
          factor(
            levels = c(
              "55 CGG repeats",
              "100 CGG repeats",
              if(include_200_cutoff) "200 CGG repeats"
            )
          )
      ),
      aes(
        xintercept = x,
        col = col),
      linetype = "dashed"
    ) +
    # geom_vline(
    #   aes(
    #     xintercept = 200,
    #     col = "200 CGG repeats (pre- vs full- mutation)")) +
    theme_bw() +
    theme(legend.position = "bottom") +
    labs(colour = "") +
    ylab("# study participants") +
    expand_limits(x = 0) +
    # scale_x_log10() +
    xlab("# CGG repeats")

  # ---------------------------------------------------------------


  if(!is.null(rows) || !is.null(cols))
  {
    plot1 =
      plot1 +
      facet_grid(
        rows = rows,
        cols = cols)
  }

  return(plot1)
}
