file_path = fs::path_package("extdata/synthetic_data.xlsx", package = "fxtas")
library(readxl)
sim_data = file_path |> readxl::read_excel()

usethis::use_data(sim_data, overwrite = TRUE)
