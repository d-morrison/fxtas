# following https://rstudio.github.io/reticulate/articles/python_dependencies.html

#' Install the `pySuStaIn` python package from github
#'
#'
#' @param ...
#' @inheritParams reticulate::py_install
#'
#' @return
#' @export
#'
install_pySuStaIn <- function(envname = "r-pySuStaIn", method = "auto", ...) {
  reticulate::py_install(
    "git+https://github.com/d-morrison/pySuStaIn",
    pip = TRUE,
    envname = envname,
    method = method,
    ...)
}

# conflicts with .onLoad.R; haven't figured out yet what I'm supposed to do.
# .onLoad <- function(...) {
#   use_virtualenv("r-pySuStaIn", required = FALSE)
# }
