#' Plot cross-validated per-fold log-likelihood distributions
#'
#' @param cv_loglik [matrix()] with rows corresponding to cross-validation folds and columsn corresponding to number of latent subgroups
#'
#' @return a [ggplot2::ggplot()]
#' @export
#'
plot_cv_loglik = function(cv_loglik)
{
  colnames(cv_loglik) = 1:ncol(cv_loglik)
  cv_loglik |>
    as_tibble() |>
    mutate(fold = 1:n() |> as.character()) |>
    tidyr::pivot_longer(
      cols = 1:ncol(cv_loglik) |> as.character(),
      values_to = "loglik",
      names_to = "# subgroups"
    ) |>
    ggplot(aes(x = `# subgroups`, y = loglik, col = fold)) +
    xlab("# latent subgroups") +
    geom_point() +
    geom_line(aes(group = fold, linetype = fold)) +
    # geom_boxplot() +
    theme_bw() +
    theme(legend.position = "bottom") +
    ylab("Log-likelihood of cross-validation test folds")


}
