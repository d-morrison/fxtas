# see SuStaIn-simulated-data.qmd for the full script to generate this data

library(fxtas)
library(reticulate)
results =
  "output/pickle_files/sample_data_subtype2.pickle" |>
  py_load_object() |>
  force()

sim_subtype_and_stage_table = results |>
  extract_subtype_and_stage_table()

usethis::use_data(sim_subtype_and_stage_table,
                  overwrite = TRUE)
