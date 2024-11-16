#' Plot a CVIC curve
#'
#' @param CVIC [numeric()] vector of CVIC values, ordered by number of subtypes
#'
#' @return a [ggplot2::ggplot()]
#' @export
#'
plot_CVIC <- function(CVIC) {
  tibble(
    CVIC = CVIC,
    `# subtypes` = 1:length(temp$CVIC)
  ) |>
    ggplot(aes(x = .data$`# subtypes` |> factor(), y = .data$CVIC, group = 1)) +
    geom_line() +
    geom_point() +
    xlab("# subtypes") +
    theme_bw()
}
