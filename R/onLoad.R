.onLoad <- function(...) {
  message('Loading virtual environment "r-pySuStaIn"')
  reticulate::use_virtualenv("r-pySuStaIn", required = TRUE)
}
