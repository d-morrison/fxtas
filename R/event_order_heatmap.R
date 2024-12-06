#' Event order heatmap
#'
#' @param samples a list of orderings
#' @param biomarkers todo
#' @param biomarker_order todo
#' @param verbose whether to print messages
#'
#' @return a ggplot object that constructs a heatmap
#' @export
#'
event_order_heatmap <- function(
    samples,
    biomarkers = attr(samples, "biomarker labels"),
    biomarker_order = NULL,
    verbose = FALSE)
{
  if (verbose) cli::cli_alert("starting `event_order_heatmap()`")
  positions = paste0("P", 1:length(biomarkers))

  if (inherits(samples[[1]]$ordering, "symbol"))
    browser(cli::cli_inform("not sure why `inherits(samples[[1]]$ordering, 'symbol)`"))

  b =
    samples |>
    sapply(X = _,
           FUN <- function(x)
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
    dplyr::mutate(
      x = x |> factor(levels = positions),
      y =
        biomarkers[y] |>
        factor(levels = biomarkers[b2[1,positions] |> unlist()]),
      heat = n/length(samples)
    )



  # b2 = b |> apply(M = 1, FUN = table) |> bind_rows() |> as.matrix()
  # b2[is.na(b2)] = 0
  # b3 = sweep(b2, MARGIN = 2, FUN = "/", STATS = colSums(b2))
  # colnames(b3) = biomarkers[as.numeric(colnames(b3))]
  # b4 = b3 |> as_tibble() |> dplyr::mutate(x = 1:nrow(b3) |> factor())
  # b5 = b4 |>
  #   tidyr::pivot_longer(cols = biomarkers,
  #                       names_to = "y",
  #                       values_to = "heat") |>
  #   dplyr::mutate(y = factor(y, levels = rev(colnames(b3))))

}
