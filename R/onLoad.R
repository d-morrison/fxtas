pySuStaIn = NULL

.onLoad <- function(...) {
  reticulate::use_virtualenv("r-pySuStaIn", required = FALSE)
  pySuStaIn <<- reticulate::import("pySuStaIn", delay_load = TRUE)
}
