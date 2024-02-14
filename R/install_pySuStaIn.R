#' @title Install the `pySuStaIn` python package from github
#' @description
#' This function is a wrapper for [reticulate::conda_install].
#' Its implementation follows the instructions in:
#' - https://rstudio.github.io/reticulate/articles/package.html
#' - https://rstudio.github.io/reticulate/articles/python_dependencies.html
#' @details
#' ## `python_version`
#'
#' @param ...
#' @inheritParams reticulate::conda_install
#'
#' @return
#' @export
#'
install_pySuStaIn <- function(
    envname = "r-pySuStaIn",
    python_version = "<3.10",
    ...)
{
  reticulate::conda_install(
    "git+https://github.com/d-morrison/pySuStaIn",
    envname = envname,
    method = method,
    pip = TRUE,
    python_version = python_version,
    ...)
}

# conflicts with .onLoad.R; haven't figured out yet what I'm supposed to do.
# .onLoad <- function(...) {
#   use_virtualenv("r-pySuStaIn", required = FALSE)
# }
