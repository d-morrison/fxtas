file_path = fs::path_package("extdata/sim_data/synthetic_data.xlsx", package = "fxtas")
library(readxl)
sim_data =
  file_path |>
  readxl::read_excel() |>
  mutate(Male = (.data$Sex == "Male"),
         across(
           .cols = starts_with("Biomarker"),
           .fns = as.factor))



usethis::use_data(sim_data, overwrite = TRUE)
