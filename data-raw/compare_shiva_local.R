library(fxtas)
local = extract_results_from_pickle(
  output_folder = "output/output.longest",
  format_sst = FALSE,
  dataset_name = "sample_data_fold0",

)
shiva = extract_results_from_pickle(
  output_folder = "output/output.longest_shiva/",
  format_sst = FALSE,
  dataset_name = "sample_data_fold0"

)
