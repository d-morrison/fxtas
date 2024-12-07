#' @title Install the `pySuStaIn` python package from github
#' @description
#' This function is a wrapper for [reticulate::conda_install].
#' Its implementation follows the instructions in:
#' - https://rstudio.github.io/reticulate/articles/package.html
#' - https://rstudio.github.io/reticulate/articles/python_dependencies.html
#' @details
#' ## `python_version`
#' `pySuStaIn` and its dependency `kde_ebm` currently (2024-02-14) do not appear to be  with python >= 3.10.
#' ## `pip`
#' `pip = TRUE` appears to be necessary,
#' since `pySuStaIn` needs to be installed directly from <github.com>
#' @inheritDotParams reticulate::py_install
#' @inheritParams reticulate::py_install
#'
#' @inherit reticulate::py_install return
#' @export
#'
install_pySuStaIn <- function(
    envname = "r-pySuStaIn",
    python_version = "<3.10",
    method = "auto",
    pip = TRUE,
    ...)
{
  reticulate::py_install(
    packages = "git+https://github.com/ucd-iddrc/pySuStaIn",
    envname = envname,
    pip = pip,
    python_version = python_version,
    ...)
}

# conflicts with .onLoad.R; haven't figured out yet what I'm supposed to do.
# .onLoad <- function(...) {
#   use_virtualenv("r-pySuStaIn", required = FALSE)
# }
