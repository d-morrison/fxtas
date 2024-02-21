pySuStaIn = NULL

#' @title Actions taken when `fxtas` is loaded
#' @description
#' based on https://rstudio.github.io/reticulate/articles/package.html#delay-loading-python-modules
#'
#' @param ...
#'
#' @return
.onLoad <- function(...)
{
  message('loading `fxtas`')
  reticulate::use_virtualenv("r-pySuStaIn", required = FALSE)
  # reticulate::use_virtualenv("r-pySuStaIn", required = TRUE)

  # reticulate::use_condaenv("r-pySuStaIn", required = TRUE)
  # reticulate::use_condaenv("r-pySuStaIn", required = FALSE)

  pySuStaIn <<- reticulate::import(
    module = "pySuStaIn",
    delay_load = TRUE)
}
