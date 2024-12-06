#' Plot cross-validated per-fold log-likelihood distributions
#'
#' @param cv_loglik [matrix()] with rows corresponding to cross-validation folds and columns corresponding to number of latent subgroups
#' @param y_text_size [integer]
#' @return a [ggplot2::ggplot()]
#' @export
#'
plot_cv_loglik <- function(cv_loglik, y_text_size = 8)
{
  colnames(cv_loglik) = 1:ncol(cv_loglik)
  cv_loglik |>
    as_tibble() |>
    dplyr::mutate(fold = 1:n() |> as.character()) |>
    tidyr::pivot_longer(
      cols = 1:ncol(cv_loglik) |> as.character(),
      values_to = "loglik",
      names_to = "# subgroups"
    ) |>
    ggplot(aes(x = `# subgroups`, y = loglik, col = fold)) +
    xlab("# subtypes") +
    geom_point() +
    geom_line(aes(group = fold, linetype = fold)) +
    # geom_boxplot() +
    theme_bw() +
    theme(legend.position = "none",
          axis.text.y = ggtext::element_markdown(
            size = y_text_size
          )) +
    ylab("Log-likelihood of CV test folds")


}
