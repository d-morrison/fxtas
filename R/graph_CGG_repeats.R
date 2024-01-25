#' Barplot of CGG repeats
#'
#' @param data a [data.frame] containing a [numeric] or [integer] column named `CGG`
#'
#' @return a [ggplot2::ggplot] object
#' @export
#'
#' @examples
#' visit1 |> graph_CGG_repeats()
graph_CGG_repeats = function(data)
{
  data |>
    ggplot(aes(x = .data$CGG)) +
    geom_bar(alpha = .5) +
    geom_vline(
      aes(
        xintercept = 55,
        col =
          "55 CGG repeats (control vs case)" #|>
        # factor(
        #   levels = c("55 CGG repeats (control vs case)",
        #              "200 CGG repeats (pre- vs full- mutation)"))
        )
      ) +
    geom_vline(
      aes(
        xintercept = 200,
        col = "200 CGG repeats (pre- vs full- mutation)")) +
    theme_bw() +
    theme(legend.position = "bottom") +
    labs(colour = "") +
    ylab("# study participants") +
    scale_x_log10() +
    xlab("# CGG repeats (logarithmic spacing)")
}
