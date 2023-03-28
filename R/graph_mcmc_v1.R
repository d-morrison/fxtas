graph_mcmc_v1 = function(likelihoods, alpha = 0.5)
{

  likelihoods =
    likelihoods |>
    as_tibble() |>
    setNames(
      paste(1:ncol(py$samples_likelihood), "subtype(s)")
    ) |>
    mutate(Iteration = row_number())


  ggplot() +
    geom_line(
      alpha = alpha,
      aes(
        x = 1:nrow(likelihoods),
        y = likelihoods[[1]],
        col = "One subtype"
      )
    ) +
    geom_line(
      alpha = alpha,
      aes(
        x = 1:nrow(likelihoods),
        y = likelihoods[[2]],
        col = "Two subtypes"
      )
    ) +
    geom_line(
      alpha = alpha,
      aes(
        x = 1:nrow(likelihoods),
        y = likelihoods[[3]],
        col = "Three subtypes"
      )
    )
}
