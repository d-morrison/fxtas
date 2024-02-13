pySuStaIn = NULL

.onLoad <- function(...) {
  reticulate::use_condaenv("r-pySuStaIn", required = FALSE)
  pySuStaIn <<- reticulate::import("pySuStaIn", delay_load = TRUE)
}
