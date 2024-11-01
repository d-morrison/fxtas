library(fxtas)
library(reticulate)
results =
  "output/output.fixed_CV/rds_files/sample_data_subtype3.rds" |>
  readr::read_rds()

test_subtype_and_stage_table = results |>
  extract_subtype_and_stage_table()

usethis::use_data(test_subtype_and_stage_table, overwrite = TRUE)
