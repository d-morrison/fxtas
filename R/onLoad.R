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

  reticulate::use_condaenv("r-pySuStaIn", required = TRUE)

  pySuStaIn <<- reticulate::import(
    module = "pySuStaIn",
    delay_load = TRUE)
}
