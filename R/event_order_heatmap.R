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
    biomarkers = attr(samples, "biomarker labels"),
    biomarker_order = NULL)
{

  positions = paste0("P", 1:length(biomarkers))

  if(class(samples[[1]]$ordering) == "symbol") browser()

  b =
    samples |>
    sapply(X = _,
           F = function(x)
             c(
               (x$ordering + 1) |> setNames(positions),
               score = x$score)
    ) |>
    t() |>
    as_tibble()

  b2 =
    b |>
    count(across(everything())) |>
    arrange(desc(n))


  b3 =
    b2 |>
    tidyr::pivot_longer(
    cols = positions,
    names_to = "x",
    values_to = "y"
  ) |>
    count(x,y, wt = n) |>
    mutate(
      x = x |> factor(levels = positions),
      y =
        biomarkers[y] |>
        factor(levels = biomarkers[b2[1,positions] |> unlist()]),
      heat = n/length(samples)
    )



  # b2 = b |> apply(M = 1, F = table) |> bind_rows() |> as.matrix()
  # b2[is.na(b2)] = 0
  # b3 = sweep(b2, MARGIN = 2, FUN = "/", STATS = colSums(b2))
  # colnames(b3) = biomarkers[as.numeric(colnames(b3))]
  # b4 = b3 |> as_tibble() |> mutate(x = 1:nrow(b3) |> factor())
  # b5 = b4 |>
  #   tidyr::pivot_longer(cols = biomarkers,
  #                       names_to = "y",
  #                       values_to = "heat") |>
  #   mutate(y = factor(y, levels = rev(colnames(b3))))

}
