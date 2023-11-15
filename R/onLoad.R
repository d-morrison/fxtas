pySuStaIn <- NULL

.onLoad <- function(libname, pkgname) {
  # reticulate::use_condaenv("fxtas39", required = TRUE)
  pySuStaIn <<- reticulate::import("pySuStaIn", delay_load = TRUE)
}
