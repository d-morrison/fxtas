#' Event order heatmap
#'
#' @param samples a list of orderings
#' @param biomarkers)
#'
#' @return a ggplot object that constructs a heatmap
#' @export
#'
event_order_heatmap = function(
    samples,
    biomarkers = attr(samples, "biomarker labels"))
{
  if(class(samples[[1]]$ordering) == "symbol") browser()
  b = samples |> sapply(X = _, F = function(x) x$ordering + 1)
  b2 = b |> apply(M = 1, F = table) |> bind_rows() |> as.matrix()
  b2[is.na(b2)] = 0
  b3 = sweep(b2, MARGIN = 2, FUN = "/", STATS = colSums(b2))
  colnames(b3) = biomarkers[as.numeric(colnames(b3))]
  b4 = b3 |> as_tibble() |> mutate(position = 1:nrow(b3) |> factor())
  b5 = b4 |>
    tidyr::pivot_longer(cols = biomarkers) |>
    mutate(name = factor(name, levels = rev(colnames(b3))))

  b5 |>
    ggplot2::ggplot(ggplot2::aes(x = position, y = name, fill = value)) +
    ggplot2::geom_tile() +
    ggplot2::xlab("Event Order") +
    ggplot2::scale_fill_continuous(name = "Prob.") +
    ggplot2::ylab("Biomarker")
}
